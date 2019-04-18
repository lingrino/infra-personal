variable "region" {
  type        = "string"
  description = "The region to create the remote state bucket in"
}

variable "bucket_state_name" {
  type        = "string"
  description = "The name of the remote state bucket to create. Must be globally unique."
}

variable "tags" {
  type        = "map"
  description = "A map of tags to apply to all resources"
}
