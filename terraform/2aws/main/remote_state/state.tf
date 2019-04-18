terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "lingrino-terraform-remote-state"
    key            = "aws/main/remote-state/terraform.tfstate"
    dynamodb_table = "TerraformRemoteStateLock"
    acl            = "bucket-owner-full-control"
    encrypt        = "true"
  }
}
