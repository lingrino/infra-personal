resource "aws_route53_record" "txt_keybase" {
  zone_id = "${ aws_route53_zone.zone.zone_id }"
  name    = "@"
  type    = "TXT"
  ttl     = "${ module.constants.route53_default_txt_ttl }"
  records = ["keybase-site-verification=bGi1F-LK1JuddMPjZlB84NL6kvSmQ1uK2Us0r1SMt1c"]
}
