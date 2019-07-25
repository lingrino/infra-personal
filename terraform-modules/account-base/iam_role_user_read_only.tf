resource "aws_iam_role" "read_only" {
  name        = "ReadOnly"
  description = "ReadOnly users can read all AWS resources including reading data in S3/Dynamo/etc... - see policy for full permissions"

  max_session_duration  = 43200
  assume_role_policy    = data.aws_iam_policy_document.arp_user.json
  force_detach_policies = true

  tags = merge(
    { "Name" = "ReadOnly" },
    { "description" = "ReadOnly users can read all AWS resources. including reading data in S3/Dynamo/etc... - see policy for full permissions" },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "read_only_read_only" {
  role       = aws_iam_role.read_only.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
