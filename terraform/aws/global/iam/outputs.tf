output "role_admin_arn" {
  value = "${ aws_iam_role.admin.arn }"
}

output "user_circle_srlingren_com_deployer_akid" {
  value = "${ aws_iam_access_key.circle_srlingren_com_deployer_keys.id }"
}

output "user_circle_srlingren_com_deployer_sak" {
  value = "${ aws_iam_access_key.circle_srlingren_com_deployer_keys.secret }"
}

output "user_circle_vaku_io_deployer_akid" {
  value = "${ aws_iam_access_key.circle_vaku_io_deployer_keys.id }"
}

output "user_circle_vaku_io_deployer_sak" {
  value = "${ aws_iam_access_key.circle_vaku_io_deployer_keys.secret }"
}
