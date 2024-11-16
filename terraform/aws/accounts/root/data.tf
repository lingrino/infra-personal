data "aws_caller_identity" "current" {}
data "aws_ssoadmin_instances" "lingrino" {}

locals {
  identity_store_id = tolist(data.aws_ssoadmin_instances.lingrino.identity_store_ids)[0]
  instance_arn      = tolist(data.aws_ssoadmin_instances.lingrino.arns)[0]
}

data "aws_identitystore_group" "admin" {
  identity_store_id = local.identity_store_id

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "admin"
    }
  }
}
