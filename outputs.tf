# ####################
#  apigw/outputs.tf  #
# ####################

output "apigw_cloudwatch_role_arn" {
  value = aws_api_gateway_account.main.cloudwatch_role_arn
}

output "endpoint" {
  value = aws_api_gateway_stage.main.invoke_url
}

output "execution_arn" {
  value = aws_api_gateway_rest_api.main.execution_arn
}

output "id" {
  value = aws_api_gateway_rest_api.main.id
}

output "name" {
  value = aws_api_gateway_rest_api.main.name
}

output "root_resource_id" {
  value = aws_api_gateway_rest_api.main.root_resource_id
}

output "stage_name" {
  value = aws_api_gateway_stage.main.stage_name
}

output "stage_arn" {
  value = aws_api_gateway_stage.main.arn
}

output "domain_name" {
  value = aws_api_gateway_domain_name.main.domain_name
}

output "cloudfront_zone_id" {
  value = aws_api_gateway_domain_name.main.cloudfront_zone_id
}

output "cloudfront_domain_name" {
  value = aws_api_gateway_domain_name.main.cloudfront_domain_name
}