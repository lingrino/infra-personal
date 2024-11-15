resource "tfe_variable_set" "all" {
  name         = "all"
  description  = "variables for all workspace"
  organization = tfe_organization.org.id
  global       = true
}
