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

variable "tags" {
  type        = "map"
  description = "A map of tags to add to all resources"
}

variable "create_vpn_gateway" {
  type        = "string"
  description = "Whether or not to create a VPN gateway. True or False."
  default     = true
}

variable "create_nat_gateways" {
  type        = "string"
  description = "Whether or not to create NAT gateways. These can be expensive. True or False."
  default     = true
}

variable "enabled_endpoint_gateways" {
  type        = "list"
  description = "A list of vpc endpoint gateways to enable (do not include com.amazonaws.region)"

  default = [
    "dynamodb",
    "s3",
  ]
}

variable "enabled_endpoint_interfaces" {
  type        = "list"
  description = "A list of vpc endpoint interfaces to enable (do not include com.amazonaws.region)"

  default = [
    "cloudformation",
    "cloudtrail",
    "codebuild",
    "codebuild-fips",
    "config",
    "ec2",
    "ec2messages",
    "elasticloadbalancing",
    "events",
    "execute-api",
    "kinesis-streams",
    "kms",
    "logs",
    "monitoring",
    "sagemaker.api",
    "sagemaker.runtime",
    "secretsmanager",
    "servicecatalog",
    "sns",
    "ssm",
    "ssmmessages",
  ]
}
