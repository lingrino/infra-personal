provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = [var.account_id_auth]

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id_root}:role/ServiceAdmin"
    session_name = "TerraformCloud"
  }
}
