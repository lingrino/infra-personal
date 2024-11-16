data "tfe_organization" "lingrino" {
  name = "lingrino"
}

data "tfe_variable_set" "all" {
  organization = data.tfe_organization.lingrino.name
  name         = "all"
}

data "aws_ssoadmin_instances" "lingrino" {}

locals {
  identity_store_id = tolist(data.aws_ssoadmin_instances.lingrino.identity_store_ids)[0]
}
