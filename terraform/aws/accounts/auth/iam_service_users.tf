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
