data "aws_caller_identity" "current" {}

resource "null_resource" "default_sgs" {
  triggers = {
    account_id = var.account_id
  }

  provisioner "local-exec" {
    command = "${path.module}/files/tag_default_rds_sgs.sh"

    environment = {
      ACCOUNT_ID = data.aws_caller_identity.current.account_id
    }
  }
}
