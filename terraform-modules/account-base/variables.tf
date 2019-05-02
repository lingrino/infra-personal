variable "tags" {
  type        = "map"
  description = "A map of tags to apply to all resources"
}

variable "account_id" {
  type        = "string"
  description = "The ID of the account to configure"
}

variable "account_name" {
  type        = "string"
  description = "The name of the account to configure"
}

variable "account_id_auth" {
  type        = "string"
  description = "The account ID of the auth account. Where assume role should be allowed from."
}

variable "bucket_config_arn" {
  type        = "string"
  description = "The ARN of the AWS Config bucket to write to"
}
