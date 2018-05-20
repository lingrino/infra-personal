output "cert_churner_io_arn" {
  value = "${ aws_acm_certificate.cert_churner_io.arn }"
}

output "cert_churner_io_dns_validation" {
  value = "${ aws_acm_certificate.cert_churner_io.domain_validation_options }"
}

output "cert_srlingren_com_arn" {
  value = "${ aws_acm_certificate.cert_srlingren_com.arn }"
}

output "cert_srlingren_com_dns_validation" {
  value = "${ aws_acm_certificate.cert_srlingren_com.domain_validation_options }"
}
