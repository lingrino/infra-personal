resource "aws_iam_user" "terraform_cloud" {
  name = "terraform-cloud"
  path = "/service/"

  force_destroy = true

  tags = merge(
    { "Name" = "terraform-cloud" },
    { "description" = "This user should be used by terraform cloud to run CI" },
    var.tags
  )
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
  terraform_cloud_akid = try(aws_iam_access_key.terraform_cloud_even.0.id, aws_iam_access_key.terraform_cloud_odd.0.id)
  terraform_cloud_sak  = try(aws_iam_access_key.terraform_cloud_even.0.secret, aws_iam_access_key.terraform_cloud_odd.0.secret)

  # The set of workspaces that should have the terraform cloud variables and secrets
  # All of the workspaces that start with org/aws-*
  user_tf_cloud_workspaces = toset([
    for ws in data.terraform_remote_state.terraform.outputs.workspace_ids :
    ws if length(regexall("^*/aws-*", ws)) > 0
  ])
}

resource "tfe_variable" "assume_role_name" {
  for_each = local.user_tf_cloud_workspaces

  workspace_id = each.key
  category     = "terraform"

  key   = "assume_role_name"
  value = "ServiceAdmin"
}

resource "tfe_variable" "assume_role_session_name" {
  for_each = local.user_tf_cloud_workspaces

  workspace_id = each.key
  category     = "terraform"

  key   = "assume_role_session_name"
  value = "TerraformCloud"
}

resource "tfe_variable" "terraform_cloud_akid" {
  for_each = local.user_tf_cloud_workspaces

  workspace_id = each.key
  category     = "env"

  key   = "AWS_ACCESS_KEY_ID"
  value = local.terraform_cloud_akid
}

resource "tfe_variable" "terraform_cloud_sak" {
  for_each = local.user_tf_cloud_workspaces

  workspace_id = each.key
  category     = "env"

  key       = "AWS_SECRET_ACCESS_KEY"
  value     = local.terraform_cloud_sak
  sensitive = true
}
