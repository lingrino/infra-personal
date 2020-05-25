# In this file we write secrets in vault to external locations. This is only preferable if we are
# writing to somewhere that cannot read from vault itself. For example, terraform cloud cannot
# connect to our vault deployment.

locals {
  workspace_names_to_ids = data.terraform_remote_state.terraform.outputs.workspace_names_to_ids
}

data "vault_generic_secret" "github_github_token" {
  path = "kv/github/terraform-cloud"
}

resource "tfe_variable" "github_github_token" {
  workspace_id = local.workspace_names_to_ids["github"]
  category     = "env"

  description = "token used with the github provider"
  key         = "GITHUB_TOKEN"
  value       = data.vault_generic_secret.github_github_token.data.pat
  sensitive   = true
}

data "vault_generic_secret" "datadog_terraform" {
  path = "kv/datadog/terraform"
}

resource "tfe_variable" "datadog_terraform_apikey" {
  workspace_id = local.workspace_names_to_ids["datadog"]
  category     = "env"

  description = "api key used with the datadog provider"
  key         = "DATADOG_API_KEY"
  value       = data.vault_generic_secret.datadog_terraform.data.api
  sensitive   = true
}

resource "tfe_variable" "datadog_terraform_appkey" {
  workspace_id = local.workspace_names_to_ids["datadog"]
  category     = "env"

  description = "app key used with the datadog provider"
  key         = "DATADOG_APP_KEY"
  value       = data.vault_generic_secret.datadog_terraform.data.app
  sensitive   = true
}


data "vault_generic_secret" "auth_tfe_token" {
  path = "kv/terraform/tfe-workspace-auth"
}

resource "tfe_variable" "auth_tfe_token" {
  workspace_id = local.workspace_names_to_ids["aws-accounts-auth"]
  category     = "env"

  description = "token used with the terraform provider"
  key         = "TFE_TOKEN"
  value       = data.vault_generic_secret.auth_tfe_token.data.key
  sensitive   = true
}

data "vault_generic_secret" "terraform_tfe_token" {
  path = "kv/terraform/tfe-workspace-terraform"
}

resource "tfe_variable" "terraform_tfe_token" {
  workspace_id = local.workspace_names_to_ids["terraform"]
  category     = "env"

  description = "token used with the terraform provider"
  key         = "TFE_TOKEN"
  value       = data.vault_generic_secret.terraform_tfe_token.data.key
  sensitive   = true
}
