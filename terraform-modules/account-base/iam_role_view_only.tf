resource "aws_iam_role" "view_only" {
  name               = "ViewOnly"
  description        = "ViewOnly users can view all AWS resources but not read their content - See policy for full permissions"
  assume_role_policy = data.aws_iam_policy_document.arp_users.json

  max_session_duration = 43200

  tags = merge(
    {"Name" = "ViewOnly"},
    {"description" = "ViewOnly users can view all AWS resources but not read their content - See policy for full permissions"},
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "view_only_view_only" {
  role       = aws_iam_role.view_only.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}
