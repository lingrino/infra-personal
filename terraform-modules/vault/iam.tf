resource "aws_iam_role" "ec2" {
  name_prefix        = "${var.name_prefix}-ec2-"
  assume_role_policy = data.aws_iam_policy_document.ec2_trust_policy.json

  tags = merge(
    { "Name" = "${var.name_prefix}-ec2" },
    var.tags,
  )
}

resource "aws_iam_role_policy" "ec2" {
  name_prefix = "${var.name_prefix}-ec2-"
  role        = aws_iam_role.ec2.id
  policy      = data.aws_iam_policy_document.ec2.json
}

resource "aws_iam_instance_profile" "ec2" {
  name_prefix = "${var.name_prefix}-ec2-"
  role        = aws_iam_role.ec2.name
}
