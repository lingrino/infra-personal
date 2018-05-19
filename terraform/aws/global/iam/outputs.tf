output "role_admin_arn" {
  value = "${ aws_iam_role.admin.arn }"
}
