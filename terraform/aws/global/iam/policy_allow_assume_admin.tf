resource "aws_iam_policy" "allow_assume_admin" {
  name        = "AllowAssumeAdmin"
  description = "Allow the entity to assume the admin role"
  policy      = "${ data.aws_iam_policy_document.allow_assume_admin_policy.json }"
}

data "aws_iam_policy_document" "allow_assume_admin_policy" {
  statement {
    sid       = "AllowAssumeAdmin"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["${ aws_iam_role.admin.arn }"]
  }
}
