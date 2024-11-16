resource "aws_identitystore_group" "viewonly" {
  identity_store_id = local.identity_store_id
  display_name      = "viewonly"
}

resource "aws_ssoadmin_permission_set" "viewonly" {
  instance_arn = local.instance_arn

  name             = "viewonly"
  session_duration = "PT12H"

  tags = {
    Name = "viewonly"
  }
}

resource "aws_ssoadmin_managed_policy_attachment" "viewonly" {
  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.viewonly.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

resource "aws_ssoadmin_account_assignment" "viewonly" {
  for_each = local.nonmanagement_account_ids

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.viewonly.arn

  principal_type = "GROUP"
  principal_id   = aws_identitystore_group.viewonly.group_id

  target_type = "AWS_ACCOUNT"
  target_id   = each.value
}
