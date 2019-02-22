output "domain_srlingren_com_verification_token" {
  value = "${ aws_ses_domain_identity.srlingren_com.verification_token }"
}

output "domain_srlingren_com_dkim_tokens" {
  value = "${ aws_ses_domain_dkim.srlingren_com.dkim_tokens }"
}

output "domain_srlingren_com_mail_from_domain" {
  value = "${ aws_ses_domain_mail_from.srlingren_com.mail_from_domain }"
}

output "domain_vaku_io_verification_token" {
  value = "${ aws_ses_domain_identity.vaku_io.verification_token }"
}

output "domain_vaku_io_dkim_tokens" {
  value = "${ aws_ses_domain_dkim.vaku_io.dkim_tokens }"
}

output "domain_vaku_io_mail_from_domain" {
  value = "${ aws_ses_domain_mail_from.vaku_io.mail_from_domain }"
}
