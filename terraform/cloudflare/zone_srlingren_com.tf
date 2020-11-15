module "zone_srlingren_com" {
  source = "../../terraform-modules/zone//"

  domain = "srlingren.com"

  ses_sns_arn          = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn
  keybase_record_value = "keybase-site-verification=bGi1F-LK1JuddMPjZlB84NL6kvSmQ1uK2Us0r1SMt1c"

  enable_gsuite             = true
  gsuite_dkim_value         = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo7HmWKU/xhMAUO/GweIdMkgY6f9RyyJ7EOJWYZuE/abkVRe4JDAPBXT9ZRnPFzIpp4ssBiN1eCV3JrjNdB2Opj37ljX1NGiN/CMWUam42g1IV8ZzLMxST2YnQhQf0R83bCvwf7LkRGfPZBHFj6Cg8zw7vmQruOlCPYgHgFLVAmvvwj/CtGMBmqKKm9ZDvN25KOOD8b/uPFhHTVr+zXsRYog0rqKkaXeGToXaQLc8s/Aiu2RZhgknfb5ORjE49PswjMfW5QsfW0X5+5iU8a3c6IJ1bCo0XmereSpKdXK8Fvqi1s/cQJcWOCIukjq2mJz54r111m6iPphmAvlRIBTmnwIDAQAB"
  google_site_verifications = ["google-site-verification=y9QbGPES67hmtkoOIs1B9Fgfk-w4uceEemqtIL-jfYM"]
}

# https://developers.cloudflare.com/workers/platform/routes#subdomains-must-have-a-dns-record
# (sub)domains must have a record associated with them for cloudflare workers to respond even if the
# worker is the only thing that should respond (static site). 100:: is the reserved discard prefix
# which forces cloudflare to create records that the worker runs against.
resource "cloudflare_record" "srlingren_com_discard" {
  for_each = toset(["@", "www"])

  zone_id = module.zone_srlingren_com.zone_id
  proxied = true
  name    = each.key
  type    = "AAAA"
  value   = "100::"
}
