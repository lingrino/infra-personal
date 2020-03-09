module "zone_srlingren_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "srlingren.com"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  enable_gsuite             = true
  keybase_record_value      = "keybase-site-verification=bGi1F-LK1JuddMPjZlB84NL6kvSmQ1uK2Us0r1SMt1c"
  gsuite_dkim_value         = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo7HmWKU/xhMAUO/GweIdMkgY6f9RyyJ7EOJWYZuE/abkVRe4JDAPBXT9ZRnPFzIpp4ssBiN1eCV3JrjNdB2Opj37ljX1NGiN/CMWUam42g1IV8ZzLMxST2YnQhQf0R83bCvwf7LkRGfPZBHFj6Cg8zw7vmQruOlCPYgHgFLVAmvvwj/CtGMBmqKKm9ZDvN25KOOD8b/uPFhHTVr+zXsRYog0rqKkaXeGToXaQLc8s/Aiu2RZhgknfb5ORjE49PswjMfW5QsfW0X5+5iU8a3c6IJ1bCo0XmereSpKdXK8Fvqi1s/cQJcWOCIukjq2mJz54r111m6iPphmAvlRIBTmnwIDAQAB"
  google_site_verifications = ["google-site-verification=y9QbGPES67hmtkoOIs1B9Fgfk-w4uceEemqtIL-jfYM"]
  ses_sns_arn               = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}
