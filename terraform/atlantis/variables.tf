variable "account_id" {
  type        = string
  description = "The ID of the AWS Account"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}
