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
}
