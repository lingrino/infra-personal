resource "aws_identitystore_user" "sean" {
  identity_store_id = local.identity_store_id

  user_name    = "sean@lingren.com"
  display_name = "sean lingren"

  emails {
    value   = "sean@lingren.com"
    primary = true
  }

  name {
    given_name  = "sean"
    family_name = "lingren"
  }
}

resource "aws_identitystore_group_membership" "sean_admin" {
  identity_store_id = local.identity_store_id
  group_id          = aws_identitystore_group.admin.group_id
  member_id         = aws_identitystore_user.sean.user_id
}

resource "aws_identitystore_group_membership" "sean_readonly" {
  identity_store_id = local.identity_store_id
  group_id          = aws_identitystore_group.readonly.group_id
  member_id         = aws_identitystore_user.sean.user_id
}

resource "aws_identitystore_group_membership" "sean_viewonly" {
  identity_store_id = local.identity_store_id
  group_id          = aws_identitystore_group.viewonly.group_id
  member_id         = aws_identitystore_user.sean.user_id
}
