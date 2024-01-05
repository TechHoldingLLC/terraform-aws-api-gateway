# API Gateway
Below is an example of calling this module.

## Create an API Gateway
```
module "apigw_api" {
  source          = "./apigw"
  apigw_name      = "my-apigw-name"
  stage_name      = "my-stage-name"
  domain_name     = module.acm_api.domain_name
  certificate_arn = module.acm_api.arn
  providers = {
    aws = aws
  }
}
```