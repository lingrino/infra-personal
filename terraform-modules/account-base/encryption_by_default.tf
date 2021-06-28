# There is a terraform resource but it only works for the current region
# and it's easier to run this script than to create a new AWS provider
# for every single region and loop over the terraform resource.
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_default_kms_key

resource "null_resource" "encryption_by_default" {
  triggers = {
    account_id = var.account_id
  }

  provisioner "local-exec" {
    command = "${path.module}/files/encryption_by_default.sh"

    environment = {
      ACCOUNT_ID = data.aws_caller_identity.current.account_id
    }
  }
}
