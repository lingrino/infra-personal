provider "aws" {
  alias  = "root"
  region = "us-east-1"

  profile             = !can(var.tfc_aws_dynamic_credentials.aliases["root"]) ? "root" : null
  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["root"].shared_config_file], null)

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

module "account_root" {
  source = "../../../../terraform-modules/account//"

  name  = "root"
  email = "sean+aws-root@lingren.com"
}

module "account_root_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_root.id
  account_name = module.account_root.name

  account_id_audit = module.account_audit.id
  account_id_auth  = module.account_auth.id

  providers = {
    aws = aws.root
  }
}
