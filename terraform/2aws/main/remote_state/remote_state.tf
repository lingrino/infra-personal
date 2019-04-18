module "remote_state" {
  source = "../../../modules/aws/terraform_remote_state//"

  region            = "us-east-1"
  bucket_state_name = "lingrino-terraform-remote-state"

  tags = "${ var.tags }"
}
