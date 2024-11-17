variable "account_id" {
  type        = string
  description = "The ID of the account to configure"
}

variable "account_name" {
  type        = string
  description = "The name of the account to configure"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
  default     = {}
}
