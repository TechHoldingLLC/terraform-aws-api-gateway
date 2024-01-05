########################
# apigw/cloudwatch.tf  #
########################

#-------------------------------------
# Cloudwatch Log Group For Access Logs
#-------------------------------------
resource "aws_cloudwatch_log_group" "apigw_access_logs" {
  name              = "API-Gateway-Access-Logs_${aws_api_gateway_rest_api.main.id}/${var.stage_name}"
  retention_in_days = var.retention_in_days
}

#----------------------------------------
# Cloudwatch Log Group For Execution Logs
#----------------------------------------
resource "aws_cloudwatch_log_group" "apigw_execution_logs" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.main.id}/${var.stage_name}"
  retention_in_days = var.retention_in_days
}