data "aws_caller_identity" "current" {}

resource "null_resource" "default_vpcs" {
  triggers = {
    account_id = "${ var.account_id }"
  }

  provisioner "local-exec" {
    command = "${ path.module }/files/remove_default_vpcs.sh"

    environment {
      ACCOUNT_ID = "${ data.aws_caller_identity.current.account_id }"
    }
  }
}
