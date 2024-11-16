data "aws_ssoadmin_instances" "lingrino" {}

locals {
  identity_store_id = tolist(data.aws_ssoadmin_instances.lingrino.identity_store_ids)[0]
  instance_arn      = tolist(data.aws_ssoadmin_instances.lingrino.arns)[0]

  nonmanagement_account_ids = toset([
    for alias, id in data.terraform_remote_state.common_organization.outputs.account_aliases_to_account_ids
    : id if alias != "lingrino-root"
  ])
}
