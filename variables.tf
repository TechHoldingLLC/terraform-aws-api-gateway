########################
#  apigw/variables.tf  #
########################

# Required Variables
variable "apigw_name" {
  description = "API Gateway name"
  type        = string
}

variable "certificate_arn" {
  description = "arn for acm certificate"
  type        = string
}

variable "domain_name" {
  description = "apigateway domain name"
  type        = string
}

variable "stage_name" {
  description = "Apigateway stage name"
  type        = string
}

# Optional Variables
variable "binary_media_types" {
  description = " List of binary media types supported by the REST API"
  type        = list(string)
  default     = null
}

variable "data_trace_enabled" {
  description = "Whether data trace logging is enabled for this method"
  type        = bool
  default     = false
}

variable "logging_level" {
  description = "Logging level for this method: 'OFF','ERROR', 'INFO'"
  type        = string
  default     = "INFO"
}

variable "metrics_enabled" {
  description = "Whether Amazon CloudWatch metrics are enabled for this method"
  type        = bool
  default     = true
}

variable "retention_in_days" {
  description = "The number of days to retain log events in the Access and Execution Log groups"
  type        = number
  default     = 30
}

variable "security_policy" {
  description = "Transport Layer Security(TLS) version + cipher suite for this DomainName"
  type        = string
  default     = "TLS_1_2"
}

variable "throttling_burst_limit" {
  description = "The number of requests your API can handle concurrently"
  type        = number
  default     = null
}

variable "throttling_rate_limit" {
  description = "The number of allowed requests per second"
  type        = number
  default     = null
}