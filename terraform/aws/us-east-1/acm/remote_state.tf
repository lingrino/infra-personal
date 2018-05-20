terraform {
  backend "s3" {
    region         = "us-east-2"
    bucket         = "terraform-remote-state-20180519193152524300000001"
    key            = "aws/us-east-1/acm/terraform.tfstate"
    dynamodb_table = "TerraformRemoteStateLock"

    acl        = "bucket-owner-full-control"
    encrypt    = "true"
    kms_key_id = "95a2d555-e9fd-4aec-a944-377f1073a747"
  }
}
