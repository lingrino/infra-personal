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
  type        = set(string)
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

variable "inbound_cidrs" {
  type        = set(string)
  description = "A set of cidrs to allow into the bastion. Should be the tailscale cidr."
  default     = []
}
