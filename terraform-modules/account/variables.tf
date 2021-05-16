variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
  default     = {}
}

variable "name" {
  type        = string
  description = "The name of the account to create"
}

variable "email" {
  type        = string
  description = "The email address to create the account with"
}
