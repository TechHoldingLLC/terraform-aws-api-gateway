# API Gateway
Below is an example of how to use this module.

## Create an EDGE Optimized API Gateway
```hcl
module "apigw_api" {
  source          = "./apigw"
  apigw_name      = "my-apigw-name"
  stage_name      = "my-stage-name"
  endpoint_type   = "EDGE"
  domain_name     = module.acm_api.domain_name
  certificate_arn = module.acm_api.arn
  providers = {
    aws = aws
  }
}
```

## Create a Regional API Gateway
```hcl
module "apigw_api" {
  source                   = "./apigw"
  apigw_name               = "my-apigw-name"
  stage_name               = "my-stage-name"
  endpoint_type            = "REGIONAL"
  domain_name              = module.acm_api.domain_name
  regional_certificate_arn = module.acm_api.arn
  providers = {
    aws = aws
  }
}
```

## Note: Migrating Endpoints

To migrate your custom domain name to a regional or edge endpoint, first remove the existing custom domain name from the AWS Console. After removal, add the new custom domain endpoint of your choice using this module.

Example error:
```
400, RequestID: XXXX-XXXX, BadRequestException: /endpointConfiguration/types/0 Invalid request input 
```