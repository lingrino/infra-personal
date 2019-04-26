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

variable "account_alias" {
  type        = "string"
  description = "The desired alias for the account"
}
