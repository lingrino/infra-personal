#     "builders": [
#         {
#             "ssh_username": "ec2-user",

#             "vpc_id": "{{user `builder_vpc_id`}}",
#             "subnet_id": "{{user `builder_subnet_id`}}",
#             "run_volume_tags": {
#                 "Name": "Vault {{user `vault_version`}} Builder",
#                 "build_date": "{{ timestamp }}",
#                 "packer": true,
#                 "packer_version": "{{ packer_version }}"
#             },
#         }
#     ],
#     "provisioners": [
#         {
#             "type": "shell",
#             "inline": [
#                 "yum install -y sudo shadow-utils systemd python3"
#             ],
#             "only": [
#                 "docker-amazonlinux2"
#             ]
#         },
#         {
#             "type": "ansible",
#             "playbook_file": "./ansible/site.yml",
#             "extra_arguments": [
#                 "--extra-vars",
#                 "vault_version={{user `vault_version`}} vault_version_checksum={{user `vault_version_checksum`}}"
#             ]
#         }
#     ]
# }

source "docker" "amazonlinux2" {
  image = "amazonlinux:2"
  discard = true
}

source "amazon-ebs" "aws" {
  region = "us-east-1"
  shutdown_behavior = "terminate"

  subnet_filter {
    filters {
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
  spot_instance_types = [
    "t3.nano",
    "t3.micro",
    "t3.small",
    "t3.medium",
  ]

  spot_tags {
    key = "tags to apply to the ami"
    name = "name"
    os = "OS"
    build_date = ""
    packer = true
    packer_version = "packer version here"
  }


  run_tags {
    key = "tags to apply to the ami"
    name = "name"
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
    key = "tags to apply to the ami"
    name = "name"
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
