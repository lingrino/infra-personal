resource "tfe_workspace" "vault" {
  organization = tfe_organization.org.id
  name         = "vault"

  operations = false
}
