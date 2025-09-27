data "cloudflare_account" "account" {
  account_id = "27a6422e1d64fbe9408ab703847ecdab"
}

resource "cloudflare_account" "account" {
  name = "lingrino"
  type = "standard"

  settings = {
    enforce_twofactor   = true
    abuse_contact_email = "sean@lingren.com"
  }
}
