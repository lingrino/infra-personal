provider "cloudflare" {}

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::840856573771:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }
}
