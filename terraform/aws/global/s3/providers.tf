provider "aws" {
  region              = "${ module.constants.aws_default_region }"
  allowed_account_ids = ["${ module.constants.aws_account_id }"]
}

# For buckets in us-east-1
provider "aws" {
  alias               = "us-east-1"
  region              = "us-east-1"
  allowed_account_ids = ["${ module.constants.aws_account_id }"]
}
