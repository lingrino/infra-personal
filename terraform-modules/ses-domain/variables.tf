variable "domain" {
  type        = string
  description = "The domain to validate in SES"
}

variable "zone_id" {
  type        = string
  description = "The ID of the cloudflare zone to create records in"
}

variable "ses_sns_arn" {
  type        = string
  description = "An SNS ARN to send SNS bounce, complaint, and delivery events to"
}

variable "ses_region" {
  type        = string
  description = "The region to verify SES in"
  default     = "us-east-1"
}
