#################################
### Terraform Cloud           ###
#################################
resource "aws_secretsmanager_secret" "terraform_cloud_keys_terraform_cloud" {
  name = "terraform-cloud/keys/terraform-cloud"

  tags = {
    Name = "terraform-cloud/keys/terraform-cloud"
  }
}

data "aws_secretsmanager_secret_version" "terraform_cloud_keys_terraform_cloud" {
  secret_id = aws_secretsmanager_secret.terraform_cloud_keys_terraform_cloud.id
}

resource "tfe_variable" "terraform_cloud" {
  for_each = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.terraform_cloud_keys_terraform_cloud.secret_string))

  variable_set_id = data.tfe_variable_set.all.id
  category        = "env"
  sensitive       = true

  key   = each.key
  value = each.value
}

#################################
### GitHub                    ###
#################################
resource "aws_secretsmanager_secret" "terraform_cloud_keys_github" {
  name = "terraform-cloud/keys/github"

  tags = {
    Name = "terraform-cloud/keys/github"
  }
}

data "aws_secretsmanager_secret_version" "terraform_cloud_keys_github" {
  secret_id = aws_secretsmanager_secret.terraform_cloud_keys_github.id
}

resource "github_actions_secret" "terraform_cloud" {
  for_each = nonsensitive(jsondecode(data.aws_secretsmanager_secret_version.terraform_cloud_keys_github.secret_string))

  repository      = "infra-personal"
  secret_name     = each.key
  plaintext_value = each.value
}
