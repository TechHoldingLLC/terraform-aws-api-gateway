####################
#  apigw/apigw.tf  #
####################

#-----------------------------------
# API Gateway Rest API
#-----------------------------------
resource "aws_api_gateway_rest_api" "main" {
  name                     = var.apigw_name
  minimum_compression_size = -1
  binary_media_types       = var.binary_media_types
}

#-----------------------------------
# API Gateway Deployment
#-----------------------------------
resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  depends_on = [
    aws_api_gateway_method.get,
    aws_api_gateway_integration.get_mock
  ]
}

#-----------------------------------
# API Gateway Stage and Access Logs
#-----------------------------------
resource "aws_api_gateway_stage" "main" {
  stage_name    = var.stage_name
  rest_api_id   = aws_api_gateway_rest_api.main.id
  deployment_id = aws_api_gateway_deployment.main.id

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.apigw_access_logs.arn
    format = jsonencode({
      "requestId" : "$context.requestId",
      "ip" : "$context.identity.sourceIp",
      "caller" : "$context.identity.caller",
      "user" : "$context.identity.user",
      "requestTime" : "$context.requestTime",
      "httpMethod" : "$context.httpMethod",
      "path" : "$context.path",
      "status" : "$context.status",
      "protocol" : "$context.protocol",
      "responseLength" : "$context.responseLength"
    })
  }

  lifecycle {
    ignore_changes = [
      deployment_id
    ]
  }
}

#-----------------------------------
# API Gateway Method : GET
#-----------------------------------
resource "aws_api_gateway_method" "get" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_rest_api.main.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

#-----------------------------------
# API Gateway Integration : MOCK
#-----------------------------------
resource "aws_api_gateway_integration" "get_mock" {
  rest_api_id          = aws_api_gateway_rest_api.main.id
  resource_id          = aws_api_gateway_rest_api.main.root_resource_id
  http_method          = aws_api_gateway_method.get.http_method
  type                 = "MOCK"
  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = <<EOF
{
    "statusCode": 401
}
EOF
  }
}

#-----------------------------------
# APIGW Method Settings
#-----------------------------------
resource "aws_api_gateway_method_settings" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.main.stage_name
  method_path = "*/*"

  settings {
    logging_level      = var.logging_level
    metrics_enabled    = var.metrics_enabled
    data_trace_enabled = var.data_trace_enabled

    # Limit the rate of calls to prevent abuse and unwanted charges
    throttling_rate_limit  = var.throttling_rate_limit
    throttling_burst_limit = var.throttling_burst_limit
  }
}

#-----------------------------------
# APIGW Account
#-----------------------------------
resource "aws_api_gateway_account" "main" {
  cloudwatch_role_arn = aws_iam_role.apigw_cloudwatch.arn
}

#-----------------------------------
# APIGW Gateway Response
#-----------------------------------
resource "aws_api_gateway_gateway_response" "missing_authentication_token" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  response_type = "MISSING_AUTHENTICATION_TOKEN"

  ## Update the response
  status_code = "404"
  response_templates = {
    "application/json" = "{\"message\":\"Resource not found\"}"
  }
}

#-----------------------------------
# APIGW Gateway Domain Configuration
#-----------------------------------
resource "aws_api_gateway_domain_name" "main" {
  domain_name     = var.domain_name
  certificate_arn = var.certificate_arn
  security_policy = var.security_policy
}

#---------------------------------------
# APIGW Gateway Path Mapping with Domain
#---------------------------------------
resource "aws_api_gateway_base_path_mapping" "main" {
  api_id      = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.main.stage_name
  domain_name = aws_api_gateway_domain_name.main.domain_name
}