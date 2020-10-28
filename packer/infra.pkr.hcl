locals {
  os_name       = "ubuntu"
  os_version    = "focal"
  os_ami_owner  = "099720109477"
  os_ami_filter = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"

  aws_region = "us-east-1"
  aws_tags = {
    build_date      = "{{ timestamp }}"
    os              = "${local.os_name}:${local.os_version}"
    packer          = "true"
    source_ami_id   = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }
}

source "docker" "bastion" {
  image   = "${local.os_name}:${local.os_version}"
  discard = true
}

source "docker" "vault" {
  image   = "${local.os_name}:${local.os_version}"
  discard = true
}

source "amazon-ebs" "bastion" {
  source_ami_filter {
    filters = {
      name                = local.os_ami_filter
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = [local.os_ami_owner]
    most_recent = true
  }

  region = local.aws_region

  subnet_filter {
    filters = {
      "tag:type" : "public"
      "tag:default" : "true"
    }
    random = true
  }

  spot_price = "auto"
  spot_instance_types = [
    "t3.nano",
    "t3.micro",
    "t3.small",
    "t3.medium",
  ]

  spot_tags = {
    Name            = "bastion"
    build_date      = "{{ timestamp }}"
    os              = "${local.os_name}:${local.os_version}"
    packer          = "true"
    source_ami_id   = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }

  ssh_username      = "ubuntu"
  ssh_interface     = "public_ip"
  shutdown_behavior = "terminate"

  run_tags = {
    Name            = "bastion"
    build_date      = "{{ timestamp }}"
    os              = "${local.os_name}:${local.os_version}"
    packer          = "true"
    source_ami_id   = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }

  run_volume_tags = {
    Name            = "bastion"
    build_date      = "{{ timestamp }}"
    os              = "${local.os_name}:${local.os_version}"
    packer          = "true"
    source_ami_id   = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }

  ami_name        = "bastion-{{ timestamp }}"
  ami_description = "AMI for bastion infrastructure"

  ami_regions = [local.aws_region]

  tags = {
    Name            = "bastion"
    build_date      = "{{ timestamp }}"
    os              = "${local.os_name}:${local.os_version}"
    packer          = "true"
    source_ami_id   = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }
}

source "amazon-ebs" "vault" {
  source_ami_filter {
    filters = {
      name                = local.os_ami_filter
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = [local.os_ami_owner]
    most_recent = true
  }

  region = local.aws_region

  subnet_filter {
    filters = {
      "tag:type" : "public"
      "tag:default" : "true"
    }
    random = true
  }

  spot_price = "auto"
  spot_instance_types = [
    "t3.nano",
    "t3.micro",
    "t3.small",
    "t3.medium",
  ]

  spot_tags = {
    Name            = "vault"
    build_date      = "{{ timestamp }}"
    os              = "${local.os_name}:${local.os_version}"
    packer          = "true"
    source_ami_id   = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }

  ssh_username      = "ubuntu"
  ssh_interface     = "public_ip"
  shutdown_behavior = "terminate"

  run_tags = {
    Name            = "vault"
    build_date      = "{{ timestamp }}"
    os              = "${local.os_name}:${local.os_version}"
    packer          = "true"
    source_ami_id   = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }

  run_volume_tags = {
    Name            = "vault"
    build_date      = "{{ timestamp }}"
    os              = "${local.os_name}:${local.os_version}"
    packer          = "true"
    source_ami_id   = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }

  ami_name        = "vault-{{ timestamp }}"
  ami_description = "AMI for vault infrastructure"

  ami_regions = [local.aws_region]

  tags = {
    Name            = "vault"
    build_date      = "{{ timestamp }}"
    os              = "${local.os_name}:${local.os_version}"
    packer          = "true"
    source_ami_id   = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }
}

build {
  sources = [
    "source.docker.bastion",
    "source.docker.vault",
    "source.amazon-ebs.bastion",
    "source.amazon-ebs.vault",
  ]

  provisioner "shell" {
    only = [
      "docker.bastion",
      "docker.vault",
    ]

    inline = [
      "apt-get update",
      "apt-get install -y sudo ssh systemd python3 software-properties-common",
    ]
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
    ]
  }

  provisioner "ansible" {
    only = [
      "docker.bastion",
      "amazon-ebs.bastion",
    ]

    user                = "ubuntu"
    host_alias          = "bastion"
    inventory_directory = "../ansible"
    playbook_file       = "../ansible/bastion.yml"
    groups = [
      "bastions",
    ]
  }

  provisioner "ansible" {
    only = [
      "docker.vault",
      "amazon-ebs.vault",
    ]

    user                = "ubuntu"
    host_alias          = "vault"
    inventory_directory = "../ansible"
    playbook_file       = "../ansible/vault.yml"
    groups = [
      "vaults",
    ]
  }
}
