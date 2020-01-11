source "docker" "amazonlinux2" {
  image = "amazonlinux:2"
  discard = true
}

source "amazon-ebs" "amazonlinux2" {
  ssh_username = "ec2-user"
  region = "us-east-1"
  shutdown_behavior = "terminate"

  subnet_filter {
    filters {
      tag:default = "true"
      tag:type = "public"
    }
    random = true
  }

  source_ami_filter {
    filters {
      name = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type = "ebs"
      virtualization-type = "hvm"
    }
    owners = ["amazon"]
    most_recent = true
  }

  spot_price = "auto"
  spot_price_auto_product = "Linux/UNIX (Amazon VPC)"
  spot_instance_types = [
    "t3.nano",
    "t3.micro",
    "t3.small",
    "t3.medium",
  ]

  spot_tags {
    Name = "name"
    os = "OS"
    build_date = ""
    packer = true
    packer_version = "packer version here"
  }


  run_tags {
    Name = "name"
    os = "OS"
    build_date = ""
    packer = true
    packer_version = "packer version here"
  }

  run_volume_tags {
    Name = "name"
    os = "OS"
    build_date = ""
    packer = true
    packer_version = "packer version here"
  }

  ami_name = "server"
  ami_description = "myserver"

  ami_users = [
    "all my account ids",
  ]

  ami_regions = [
    "all my regions",
  ]

  tags {
    Name = "name"
    os = "OS"
    build_date = ""
    packer = true
    packer_version = "packer version here"
  }
}

build {
  sources = [
    "source.docker.amazonlinux2"
  ]

  provisioner "shell" {
    inline = [
      "yum install -y sudo shadow-utils systemd python3"
    ]
  }
}

build {
  sources = [
    "source.docker.amazonlinux2",
    "source.amazon-ebs.amazonlinux2"
  ]

  provisioner "ansible" {
    playbook_file = "./ansible/site.yml"
  }
}
