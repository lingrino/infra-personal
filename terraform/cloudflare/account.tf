resource "cloudflare_account" "account" {
  name              = "lingrino"
  type              = "standard"
  enforce_twofactor = true
}

resource "cloudflare_account_member" "lingrino" {
  account_id    = cloudflare_account.account.id
  email_address = "sean@lingrino.com"

  role_ids = [
    "33666b9c79b9a5273fc7344ff42f953d",
  ]
}
