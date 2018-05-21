variable "tags" {
  type        = "map"
  description = "A map of tags (not including constants default tags) to add to all resources"
}

variable "vpc_id" {
  type        = "string"
  description = "The VPC to create the security groups in"
}
