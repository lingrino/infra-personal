variable "account_id_auth" {
  type        = string
  description = "The ID of the AWS Auth Account"
}

variable "tfc_aws_dynamic_credentials" {
  description = "populated by terraform cloud"
  type = object({
    default = object({
      shared_config_file = string
    })
    aliases = map(object({
      shared_config_file = string
    }))
  })
  default = {
    default = {
      shared_config_file = ""
    }
    aliases = {}
  }
}

variable "rotate_iam_keys" {
  type        = number
  description = "Increase this number by 1 to automatically rotate keys for supported IAM users"
}
