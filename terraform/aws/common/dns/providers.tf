provider "aws" {
  alias  = "audit"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::418875065733:role/ServiceAdmin"
    session_name = "TerraformCloud"
  }
}

provider "aws" {
  alias  = "auth"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::230833635140:role/ServiceAdmin"
    session_name = "TerraformCloud"
  }
}

provider "aws" {
  alias  = "dev"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::038361916180:role/ServiceAdmin"
    session_name = "TerraformCloud"
  }
}

provider "aws" {
  alias  = "prod"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::840856573771:role/ServiceAdmin"
    session_name = "TerraformCloud"
  }
}

provider "aws" {
  alias  = "root"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::241223443698:role/ServiceAdmin"
    session_name = "TerraformCloud"
  }
}
