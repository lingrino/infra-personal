variable "name_prefix" {
  type        = string
  description = "A name to prefix every created resource with"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}

variable "vpc_id" {
  type        = string
  description = "The VPC to create resources ins"
}

variable "subnets" {
  type        = list(string)
  description = "A list of subnets to launch the instance in"
}

variable "ami_owner_id" {
  type        = string
  description = "The account ID of the owner of the AMI to use"
}

variable "instance_type" {
  type        = string
  description = "The type of instance to launch the server on"
}

variable "key_name" {
  type        = string
  description = "The name of the ssh key to use for the EC2 instance"
}

variable "zone_name" {
  type        = string
  description = "The route53 zone ID for to create the record in. Will not create if left blank"
  default     = ""
}

variable "domain_name" {
  type        = string
  description = "The domain name to create. Will not create if left blank"
  default     = ""
}

variable "wg_address" {
  type        = string
  description = "The wireguard address CIDR to use for 'Address' in wg0.conf"
}

variable "wg_port" {
  type        = string
  description = "The wireguard port to use for 'ListenPort' in wg0.conf"
}
