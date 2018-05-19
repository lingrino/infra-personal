output "key_main_arn" {
  value = "${ aws_kms_key.main.arn }"
}

output "key_terraform_remote_state_arn" {
  value = "${ aws_kms_key.terraform_remote_state.arn }"
}
