output "sg_out_all_id" {
  value = "${ aws_security_group.sg_out_all.id }"
}

output "sg_out_all_name" {
  value = "${ aws_security_group.sg_out_all.name }"
}

output "sg_in_ssh_from_all_id" {
  value = "${ aws_security_group.sg_in_ssh_from_all.id }"
}

output "sg_in_ssh_from_all_name" {
  value = "${ aws_security_group.sg_in_ssh_from_all.name }"
}

output "sg_in_http_https_from_all_id" {
  value = "${ aws_security_group.sg_in_http_https_from_all.id }"
}

output "sg_in_http_https_from_all_name" {
  value = "${ aws_security_group.sg_in_http_https_from_all.name }"
}
