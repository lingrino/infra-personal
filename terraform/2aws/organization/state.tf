terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "terraform-remote-state-20190422185326314800000001"
    key            = "aws/organization/terraform.tfstate"
    dynamodb_table = "TerraformRemoteStateLock"
    acl            = "bucket-owner-full-control"
    encrypt        = "true"
  }
}
