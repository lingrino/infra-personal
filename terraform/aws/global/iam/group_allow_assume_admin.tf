resource "aws_iam_group" "allow_assume_admin" {
  name = "allow_assume_admin"
}

resource "aws_iam_policy_attachment" "allow_assume_admin_policy_attachments" {
  name       = "allow_assume_admin_policy_attachments"
  policy_arn = "${ aws_iam_policy.allow_assume_admin.arn }"
  groups     = ["${ aws_iam_group.allow_assume_admin.name }"]
}

resource "aws_iam_group_membership" "allow_assume_admin" {
  name = "allow_assume_admin_members"

  group = "${ aws_iam_group.allow_assume_admin.name }"

  users = [
    "${ aws_iam_user.sean.name }",
  ]
}
