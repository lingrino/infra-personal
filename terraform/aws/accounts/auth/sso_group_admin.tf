resource "aws_identitystore_group" "admin" {
  identity_store_id = local.identity_store_id
  display_name      = "admin"
}

resource "aws_ssoadmin_permission_set" "admin" {
  instance_arn = local.instance_arn

  name             = "admin"
  session_duration = "PT12H"

  tags = {
    Name = "admin"
  }
}

resource "aws_ssoadmin_managed_policy_attachment" "admin" {
  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.admin.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_ssoadmin_account_assignment" "admin" {
  for_each = local.nonmanagement_account_ids

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.admin.arn

  principal_type = "GROUP"
  principal_id   = aws_identitystore_group.admin.group_id

  target_type = "AWS_ACCOUNT"
  target_id   = each.value
}
