provider "aws" {
  alias  = "audit"
  region = "us-east-1"

  profile             = "audit"
  shared_config_files = try([var.tfc_aws_dynamic_credentials.aliases["audit"].shared_config_file], null)

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

module "account_audit" {
  source = "../../../../terraform-modules/account//"

  name  = "audit"
  email = "sean+aws-audit@lingren.com"
}

module "account_audit_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_audit.id
  account_name = module.account_audit.name

  account_id_audit = module.account_audit.id
  account_id_auth  = module.account_auth.id

  providers = {
    aws = aws.audit
  }
}
