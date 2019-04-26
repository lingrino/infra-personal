module "remote_state" {
  source = "../../modules/aws/terraform-remote-state//"

  name_prefix = "terraform-remote-state"

  tags = "${ var.tags }"
}

output "bucket_state_arn" {
  description = "The arn of the remote state bucket"
  value       = "${ module.remote_state.bucket_state_arn }"
}

output "bucket_state_name" {
  description = "The name of the remote state bucket"
  value       = "${ module.remote_state.bucket_state_name }"
}
