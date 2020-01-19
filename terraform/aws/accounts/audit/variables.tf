variable "account_id_audit" {
  type        = string
  description = "The ID of the AWS Audit Account"
}

variable "assume_role_name" {
  type        = string
  description = "The name of the role to Assume"
}

variable "assume_role_session_name" {
  type        = string
  description = "What to name the session when assuming the role"
}

variable "keypair_main_name" {
  type        = string
  description = "The name of the default ssh keypair to use"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}
