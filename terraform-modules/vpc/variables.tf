variable "name_prefix" {
  type        = string
  description = "a prefix to prepend to the name of all resources"
}

variable "cidr_block" {
  type        = string
  description = "the cidr block to use for the VPC"
}

variable "azs" {
  type = map(object({
    public  = string
    private = string
    intra   = string
  }))
  description = "a map of azs to types of subnets and their assigned ipv4 cidrs"
}

variable "tags" {
  type        = map(string)
  description = "a map of tags to add to all resources"
  default     = {}
}

variable "enable_nat" {
  type        = bool
  description = "whether or not to create NAT gateways"
  default     = true
}

variable "enabled_endpoint_gateways" {
  type        = set(string)
  description = "a set of vpc endpoint gateways to enable (do not include com.amazonaws.region)"

  default = [
    "dynamodb",
    "s3",
  ]
}

variable "enabled_endpoint_interfaces" {
  type        = set(string)
  description = "a set of vpc endpoint interfaces to enable (do not include com.amazonaws.region)"

  default = []
}
