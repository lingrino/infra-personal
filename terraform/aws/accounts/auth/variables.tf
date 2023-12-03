variable "account_id_auth" {
  type        = string
  description = "The ID of the AWS Auth Account"
}

variable "assume_role_name" {
  type        = string
  description = "The name of the role to Assume"
}

variable "assume_role_session_name" {
  type        = string
  description = "What to name the session when assuming the role"
}

variable "rotate_iam_keys" {
  type        = number
  description = "Increase this number by 1 to automatically rotate keys for supported IAM users"
}
