variable "assume_role_name" {
  type        = string
  description = "The name of the role to Assume"
}

variable "assume_role_session_name" {
  type        = string
  description = "What to name the session when assuming the role"
}

variable "cloudflare_account_id" {
  type        = string
  description = "The ID of the cloudflare account to configure"
}
