data "cloudflare_accounts" "lingrino" {
  name = "lingrino"
}

data "cloudflare_api_token_permissions_groups_list" "all" {
  account_id = data.cloudflare_accounts.lingrino.result[0].id
}

locals {
  account_permission_group_ids = [for k, v in data.cloudflare_api_token_permissions_groups_list.all.result : { id = v.id } if v.scopes[0] == "com.cloudflare.api.account" && v.name != "Account API Tokens Write"]
  zone_permission_group_ids    = [for k, v in data.cloudflare_api_token_permissions_groups_list.all.result : { id = v.id } if v.scopes[0] == "com.cloudflare.api.account.zone"]
}
