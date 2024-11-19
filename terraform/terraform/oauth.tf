resource "tfe_oauth_client" "github" {
  name                = "github"
  organization        = "lingrino"
  api_url             = "https://api.github.com"
  http_url            = "https://github.com"
  oauth_token         = "my-vcs-provider-token"
  service_provider    = "github"
  organization_scoped = true
}
