variable "domain_name" {
  type        = "string"
  description = "The name of the domain to delegate"
}

variable "zone_name" {
  type        = "string"
  description = "The name of the route53 zone to create delegation records in. Can leave blank if the same as var.domain_name"
  default     = ""
}

variable "ses_region" {
  type        = "string"
  description = "Default us-east-1. The region to verify SES in"
  default     = "us-east-1"
}

variable "ses_sns_arn" {
  type        = "string"
  description = "An SNS ARN to send SNS bounce, complaint, and delivery events to"
}
