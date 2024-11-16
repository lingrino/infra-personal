resource "aws_identitystore_group" "readonly" {
  identity_store_id = local.identity_store_id
  display_name      = "readonly"
}

resource "aws_ssoadmin_permission_set" "readonly" {
  instance_arn = local.instance_arn

  name             = "readonly"
  session_duration = "PT12H"

  tags = {
    Name = "readonly"
  }
}

resource "aws_ssoadmin_managed_policy_attachment" "readonly" {
  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.readonly.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_ssoadmin_account_assignment" "readonly" {
  for_each = local.nonmanagement_account_ids

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.readonly.arn

  principal_type = "GROUP"
  principal_id   = aws_identitystore_group.readonly.group_id

  target_type = "AWS_ACCOUNT"
  target_id   = each.value
}
