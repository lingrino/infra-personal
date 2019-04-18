resource "aws_iam_group" "allow_user_manage_self" {
  name = "allow_user_manage_self"
}

resource "aws_iam_policy_attachment" "allow_user_manage_self_policy_attachments" {
  name       = "allow_user_manage_self_policy_attachments"
  policy_arn = "${ aws_iam_policy.allow_user_manage_self.arn }"
  groups     = ["${ aws_iam_group.allow_user_manage_self.name }"]
}

resource "aws_iam_group_membership" "allow_user_manage_self" {
  name = "allow_user_manage_self_members"

  group = "${ aws_iam_group.allow_user_manage_self.name }"

  users = [
    "${ aws_iam_user.sean.name }",
  ]
}
