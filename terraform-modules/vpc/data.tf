data "aws_region" "current" {}

locals {
  # This is to preserve ordering across resources
  azs_list = tolist(var.azs)
}
