variable "name_prefix" {
  type        = string
  description = "A name to prefix every created resource with"
}

variable "dr_region" {
  type        = string
  description = "The AWS Region to use for disaster recovery"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}

variable "vpc_id" {
  type        = string
  description = "The VPC to create resources in"
}

variable "alb_subnets" {
  type        = list(string)
  description = "A list of subnets to launch the ALB in"
}

variable "ec2_subnets" {
  type        = list(string)
  description = "A list of subnets to launch the EC2 instances in"
}

variable "ingress_cidrs" {
  type        = list(string)
  description = "A list of CIDRs to allow traffic into the ALB"
}

variable "domain_name" {
  type        = string
  description = "The domain that points to the alb"
}

variable "certificate_arn" {
  type        = string
  description = "The ARN of the certificate to use on the ALB"
}

variable "ami_owner_id" {
  type        = string
  description = "The ID of the AMI to use to launch Vault"
}

variable "instance_type" {
  type        = string
  description = "The type of instance to launch vault on"
}

variable "key_name" {
  type        = string
  description = "The name of the ssh key to use for the EC2 instance"
}

variable "min_size" {
  type        = string
  description = "Minimum number of instances in the ASG"
}

variable "max_size" {
  type        = string
  description = "Maximum number of instances in the ASG"
}

variable "desired_capacity" {
  type        = string
  description = "Desired number of instances in the ASG"
}

variable "vault_config_dir" {
  type        = string
  description = "The directory on the OS to store the Vault configuration"
  default     = "/var/lib/vault"
}
