variable "account_id_root" {
  type        = string
  description = "The ID of the AWS Root Account"
}

variable "assume_role_name" {
  type        = string
  description = "The name of the role to Assume"
}

variable "assume_role_session_name" {
  type        = string
  description = "What to name the session when assuming the role"
}
