resource "cloudflare_access_group" "admin" {
  account_id = var.cloudflare_account_id
  name       = "admin"

  include {
    email = [
      "sean@lingrino.com",
      "srlingren@gmail.com",
    ]

    github {
      name                 = "lingrino-org"
      teams                = ["cloudflare-access-admin"]
      identity_provider_id = cloudflare_access_identity_provider.github.id
    }
  }
}

resource "cloudflare_access_identity_provider" "pin" {
  account_id = var.cloudflare_account_id

  name = "pin"
  type = "onetimepin"
}

resource "cloudflare_access_identity_provider" "github" {
  account_id = var.cloudflare_account_id

  name = "GitHub"
  type = "github"
}
