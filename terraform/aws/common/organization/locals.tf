# NOTE - Make sure you maintain alphabetical order
locals {
  account_aliases = [
    module.account_audit_base.alias,
    module.account_auth_base.alias,
    module.account_dev_base.alias,
    module.account_prod_base.alias,
    module.account_root_base.alias,
  ]

  account_arns = [
    module.account_audit.arn,
    module.account_auth.arn,
    module.account_dev.arn,
    module.account_prod.arn,
    module.account_root.arn,
  ]

  account_ids = [
    module.account_audit.id,
    module.account_auth.id,
    module.account_dev.id,
    module.account_prod.id,
    module.account_root.id,
  ]

  account_names = [
    module.account_audit.name,
    module.account_auth.name,
    module.account_dev.name,
    module.account_prod.name,
    module.account_root.name,
  ]
}
