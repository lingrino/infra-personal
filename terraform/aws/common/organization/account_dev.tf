provider "aws" {
  alias  = "dev"
  region = "us-west-2"

  profile             = !can(var.tfc_aws_dynamic_credentials.aliases["dev"]) ? "dev" : null
  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["dev"].shared_config_file], null)

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

module "account_dev" {
  source = "../../../../terraform-modules/account//"

  name  = "dev"
  email = "sean+aws-dev@lingren.com"
}

module "account_dev_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_dev.id
  account_name = module.account_dev.name

  providers = {
    aws = aws.dev
  }
}
