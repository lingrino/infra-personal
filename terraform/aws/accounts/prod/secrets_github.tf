resource "aws_secretsmanager_secret" "github_keys_terraform_cloud" {
  name = "github/keys/terraform-cloud"

  tags = {
    Name = "github/keys/terraform-cloud"
  }
}

data "aws_secretsmanager_secret_version" "github_keys_terraform_cloud" {
  secret_id = aws_secretsmanager_secret.github_keys_terraform_cloud.id
}

resource "tfe_variable" "github" {
  for_each = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.github_keys_terraform_cloud.secret_string))

  variable_set_id = data.tfe_variable_set.all.id
  category        = "env"
  sensitive       = true

  key   = each.key
  value = each.value
}
