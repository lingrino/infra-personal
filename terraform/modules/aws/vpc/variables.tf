variable "region" {
  type        = "string"
  description = "The aws region to create the resources in"
}

variable "tags" {
  type        = "map"
  description = "A map of tags (not including constants default tags) to add to all resources"
}

variable "name_prefix" {
  type        = "string"
  description = "A prefix to apply to prepend to the name of all resources"
}

variable "vpc_cidr_block" {
  type        = "string"
  description = "The cidr block to use for the VPC"
}

variable "azs" {
  type        = "list"
  description = "A list of azs to launch subnets in"
}
