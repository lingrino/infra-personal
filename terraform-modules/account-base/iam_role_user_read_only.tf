resource "aws_iam_role" "read_only" {
  name = "ReadOnly"

  max_session_duration  = 43200
  assume_role_policy    = data.aws_iam_policy_document.arp_user.json
  force_detach_policies = true

  tags = merge(var.tags, {
    Name = "ReadOnly"
  })
}

resource "aws_iam_role_policy_attachment" "read_only_read_only" {
  role       = aws_iam_role.read_only.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
