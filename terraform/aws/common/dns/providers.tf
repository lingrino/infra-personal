provider "aws" {
  alias  = "audit"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::418875065733:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }
}

provider "aws" {
  alias  = "auth"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::230833635140:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }
}

provider "aws" {
  alias  = "dev"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::038361916180:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }
}

provider "aws" {
  alias  = "prod"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::840856573771:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }
}

provider "aws" {
  alias  = "root"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::241223443698:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }
}
