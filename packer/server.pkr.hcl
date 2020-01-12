source "docker" "amazonlinux2" {
  image = "amazonlinux:2"
  discard = true
}

source "amazon-ebs" "amazonlinux2" {
  # Pick the right AMI
  source_ami_filter {
    filters {
      name = "amzn2-ami-hvm-*-x86_64-gp2"
      root-device-type = "ebs"
      virtualization-type = "hvm"
    }
    owners = ["amazon"]
    most_recent = true
  }

  # Pick where to launch the AMI
  region = "us-east-1"

  subnet_filter {
    filters {
      tag:default = "true"
      tag:type = "public"
    }
    random = true
  }

  # Pick AMI hardware
  spot_price = "auto"
  spot_price_auto_product = "Linux/UNIX (Amazon VPC)"
  spot_instance_types = [
    "t3.nano",
    "t3.micro",
    "t3.small",
    "t3.medium",
  ]

  spot_tags {
    Name = "infra-selfhosted"
    build_date = "{{ timestamp }}"
    os = "amazonlinux2"
    packer = "true"
    packer_version = "{{ packer_version }}"
    source_ami_id = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }

  # How the AMI runs
  ssh_username = "ec2-user"
  shutdown_behavior = "terminate"

  run_tags {
    Name = "infra-selfhosted"
    build_date = "{{ timestamp }}"
    os = "amazonlinux2"
    packer = "true"
    packer_version = "{{ packer_version }}"
    source_ami_id = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }

  run_volume_tags {
    Name = "infra-selfhosted"
    build_date = "{{ timestamp }}"
    os = "amazonlinux2"
    packer = "true"
    packer_version = "{{ packer_version }}"
    source_ami_id = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }

  # How to save the AMI
  ami_name = "infra-selfhosted-{{ timestamp }}"
  ami_description = "a general AMI for my self hosted infrastructure"

  ami_users = [
    "038361916180",
    "840856573771",
  ]

  ami_regions = [
    "us-east-1",
  ]

  tags {
    Name = "infra-selfhosted"
    build_date = "{{ timestamp }}"
    os = "amazonlinux2"
    packer = "true"
    packer_version = "{{ packer_version }}"
    source_ami_id = "{{ .SourceAMI }}"
    source_ami_name = "{{ .SourceAMIName }}"
  }
}

# Prepare the docker image to support ansible
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

# Provision the images
build {
  sources = [
    "source.docker.amazonlinux2",
    "source.amazon-ebs.amazonlinux2"
  ]

  provisioner "ansible" {
    playbook_file = "../ansible/site.yml"
  }
}
