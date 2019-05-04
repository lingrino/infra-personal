provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["230833635140"]
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
