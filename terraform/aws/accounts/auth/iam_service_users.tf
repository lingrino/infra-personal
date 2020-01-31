resource "aws_iam_user" "github_actions" {
  name = "github-actions"
  path = "/service/"

  force_destroy = true

  tags = merge(
    { "Name" = "github-actions" },
    { "description" = "This user should be used by github actions to run CI" },
    var.tags
  )
}

resource "aws_iam_access_key" "github_actions" {
  user   = aws_iam_user.github_actions.name
  status = "Active"
}

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

resource "aws_iam_access_key" "terraform_cloud" {
  user   = aws_iam_user.terraform_cloud.name
  status = "Active"
}

locals {
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
  value = aws_iam_access_key.terraform_cloud.id
}

resource "tfe_variable" "terraform_cloud_sak" {
  for_each = local.user_tf_cloud_workspaces

  workspace_id = each.key
  category     = "env"

  key       = "AWS_SECRET_ACCESS_KEY"
  value     = aws_iam_access_key.terraform_cloud.secret
  sensitive = true
}
