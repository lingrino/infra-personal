variable "domains" {
  type        = list(string)
  description = "A list of domains to set up healthchecks against"
}

variable "sns_arn" {
  type        = string
  description = "The ARN of an SNS topic that should be notified when the healthcheck fails"
}

variable "healthcheck_type" {
  type        = string
  description = "The type of healthcheck (default 'HTTPS' to make)"
  default     = "HTTPS"
}

variable "healthcheck_port" {
  type        = number
  description = "The port that the healthcheck uses (default 443)"
  default     = 443
}

variable "healthcheck_path" {
  type        = string
  description = "The the request path for the healthcheck (default '/')"
  default     = "/"
}

variable "healthcheck_interval" {
  type        = number
  description = "The number of seconds between pings, either 10 or 30. Default 30"
  default     = 30
}

variable "healthcheck_failure_threshold" {
  type        = number
  description = "The number of failures before the healthcheck is considered unhealthy. Default 3."
  default     = 3
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}
