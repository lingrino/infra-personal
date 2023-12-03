resource "aws_iam_role" "view_only" {
  name = "ViewOnly"

  max_session_duration  = 43200
  assume_role_policy    = data.aws_iam_policy_document.arp_user.json
  force_detach_policies = true

  tags = merge(var.tags, {
    Name = "ViewOnly"
  })
}

resource "aws_iam_role_policy_attachment" "view_only_view_only" {
  role       = aws_iam_role.view_only.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}
