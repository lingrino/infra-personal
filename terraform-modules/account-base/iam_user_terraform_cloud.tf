resource "aws_iam_user" "terraform_cloud" {
  name = "terraform-cloud"

  path          = "/ci/"
  force_destroy = true

  tags = merge(
    { "Name" = "terraform-cloud" },
    { "description" = "This user has full admin access to the account and should only be used on terraform cloud" },
    var.tags
  )
}

resource "aws_iam_user_policy_attachment" "terraform_cloud_administrator" {
  user       = aws_iam_user.terraform_cloud.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "terraform_cloud" {
  user   = aws_iam_user.terraform_cloud.name
  status = "Active"
}
