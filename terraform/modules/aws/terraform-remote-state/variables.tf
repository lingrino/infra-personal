variable "name_prefix" {
  type        = "string"
  description = "The name prefix for the terraform remote state (and log) bucket."
}

variable "tags" {
  type        = "map"
  description = "A map of tags to apply to all resources"
}

variable "create_lock_table" {
  type        = "string"
  description = "Whether or not to create a Dynamo DB lock table"
  default     = "false"
}
