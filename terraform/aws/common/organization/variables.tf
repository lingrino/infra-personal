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

variable "vantage_id" {
  type        = string
  sensitive   = true
  description = "The vantage account id"
}

variable "vantage_handshake_id" {
  type        = string
  sensitive   = true
  description = "The vantage handshake id"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}
