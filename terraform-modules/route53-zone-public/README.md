# Module - Route53 Zone Public

This module creates a public route53 zone, optionally with some standard DNS records that are common to every domain. You can use this module to create a zone and also SES domain verification, keybase domain verification, and google domains email forwarding MX records.

This module is relatively opinionated towards the services that I use (google domains, fastmail, ses, keybase). You may not find much generic use for this module if you don't use the same services. The module also requires that you are using Route53 delegation sets for white label NS records.

## Usage

The below code is a simple way of calling the module.

```terraform
resource "aws_route53_delegation_set" "example" {
  reference_name = "example"
}

module "zone_example_com" {
  source = "../path/to/module/route53-zone-public//"

  domain            = "example.com"
  delegation_set_id = aws_route53_delegation_set.example.id

  enable_fastmail = true
  keybase_record_value = "keybase-site-verification=kjfsdlkfjsdfjsd_mcweoiiier1qpcdnij"

  tags = var.tags
}
```

## Delegation Sets

Delegation sets are incredibly useful if you manage many route53 zones because they let you have a static set of NS records. This module requires that you use route53 delegation sets.

## SES Verification

This module (if `${ var.verify_ses }` is set) will create an SES sending domain equal to your domain name and add all of the necessary records to verify that domain for sending. The module does not set up *receiving* email with SES, but you can always set that up on your own.

## Keybase Verification

Keybase is a great service for proving identity on the web. If you would like to prove that you own the domain simply pass `${ var.keybase_record_value }` equal to the value keybase has chosen for you and the module will verify that you own the domain with keybase.

## Google Domains Email Forwarding

I use google domains for my domain registrar, mostly because it supports the most top level domains (`.dev`) specifically. Google domains also has a nice feature that will forward email addresses, which I use to receive email. Set `${ var.configure_google_domains_email_forwarding }` (default `true`) if you have a similar setup.

## Fastmail Verification

I use fastmail as an email provider for custom domains. You can enable fastmail domain verification by setting `${ var.enable_fastmail }` to `true` and enable fastmail web login for at `mail.${ var.domain }` by setting `${ var.enable_fastmail_webmail_login_portal }` to `true`
