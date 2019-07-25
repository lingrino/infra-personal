provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = [var.account_id_prod]

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id_prod}:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }
}
