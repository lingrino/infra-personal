provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["230833635140"]
}

provider "aws" {
  alias  = "audit"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::418875065733:role/Admin"
  }
}

provider "aws" {
  alias  = "auth"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::230833635140:role/Admin"
  }
}

provider "aws" {
  alias  = "dev"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::038361916180:role/Admin"
  }
}

provider "aws" {
  alias  = "prod"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::840856573771:role/Admin"
  }
}

provider "aws" {
  alias  = "root"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::241223443698:role/Admin"
  }
}
