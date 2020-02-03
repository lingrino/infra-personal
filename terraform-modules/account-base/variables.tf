variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}

variable "account_id" {
  type        = string
  description = "The ID of the account to configure"
}

variable "account_name" {
  type        = string
  description = "The name of the account to configure"
}

variable "account_id_audit" {
  type        = string
  description = "The account ID of the audit account"
}

variable "account_id_auth" {
  type        = string
  description = "The account ID of the auth account. Where assume role should be allowed from."
}

variable "bucket_config_arn" {
  type        = string
  description = "The ARN of the AWS Config bucket to write to"
}

# It's hard to know exactly which regions these should be without just looking
# at errors. It's defnitely not ALL regions or all regions where config is
# enabled. This list is a subset of regions based on errors I was seeing.
variable "config_authorization_regions" {
  type        = set(string)
  description = "The regions to authorize that the config account will aggregate from"
  default = [
    "us-west-1",
    "eu-west-1",
    "eu-central-1",
    "ap-northeast-1",
    "us-west-2",
    "eu-west-3",
    "ap-southeast-2",
    "ap-northeast-2",
    "ap-southeast-1",
    "eu-west-2",
    "sa-east-1",
    "us-east-1",
    "us-east-2",
    "ca-central-1",
    "ap-south-1",
  ]
}
