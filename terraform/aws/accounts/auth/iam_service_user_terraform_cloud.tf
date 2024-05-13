resource "aws_iam_user" "terraform_cloud" {
  name = "terraform-cloud"
  path = "/service/"

  force_destroy = true

  tags = {
    Name = "terraform-cloud"
  }
}

resource "aws_iam_access_key" "terraform_cloud_even" {
  count = (var.rotate_iam_keys + 1) % 2 // Exists on even rotate num

  user   = aws_iam_user.terraform_cloud.name
  status = "Active"
}

resource "aws_iam_access_key" "terraform_cloud_odd" {
  count = var.rotate_iam_keys % 2 // Exists on odd rotate num

  user   = aws_iam_user.terraform_cloud.name
  status = "Active"
}

locals {
  terraform_cloud_akid = try(aws_iam_access_key.terraform_cloud_even[0].id, aws_iam_access_key.terraform_cloud_odd[0].id)
  terraform_cloud_sak  = try(aws_iam_access_key.terraform_cloud_even[0].secret, aws_iam_access_key.terraform_cloud_odd[0].secret)
}

resource "tfe_variable" "assume_role_name" {
  variable_set_id = data.tfe_variable_set.all.id
  category        = "terraform"

  description = "name of the aws role that aws provider will assume"
  key         = "assume_role_name"
  value       = "ServiceAdmin"
}

resource "tfe_variable" "assume_role_session_name" {
  variable_set_id = data.tfe_variable_set.all.id
  category        = "terraform"

  description = "friendly name of the session that aws provider will create"
  key         = "assume_role_session_name"
  value       = "TerraformCloud"
}

resource "tfe_variable" "terraform_cloud_akid" {
  variable_set_id = data.tfe_variable_set.all.id
  category        = "env"

  description = "AWS_ACCESS_KEY_ID that will be used to assume the role"
  key         = "AWS_ACCESS_KEY_ID"
  value       = local.terraform_cloud_akid
}

resource "tfe_variable" "terraform_cloud_sak" {
  variable_set_id = data.tfe_variable_set.all.id
  category        = "env"

  description = "AWS_SECRET_ACCESS_KEY that will be used to assume the role"
  key         = "AWS_SECRET_ACCESS_KEY"
  value       = local.terraform_cloud_sak
  sensitive   = true
}
