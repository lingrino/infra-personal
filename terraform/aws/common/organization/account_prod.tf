provider "aws" {
  alias  = "prod"
  region = "us-east-1"

  profile             = !can(var.tfc_aws_dynamic_credentials.aliases["prod"]) ? "prod" : null
  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["prod"].shared_config_file], null)

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

module "account_prod" {
  source = "../../../../terraform-modules/account//"

  name  = "prod"
  email = "sean+aws-prod@lingren.com"
}

module "account_prod_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_prod.id
  account_name = module.account_prod.name

  account_id_audit = module.account_audit.id
  account_id_auth  = module.account_auth.id

  providers = {
    aws = aws.prod
  }
}
