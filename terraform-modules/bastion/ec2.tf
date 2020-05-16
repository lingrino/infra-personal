data "aws_kms_alias" "ebs" {
  name = "alias/aws/ebs"
}

data "aws_ami" "bastion" {
  owners      = [var.ami_owner_id]
  most_recent = true
  name_regex  = "bastion-*"
}

resource "aws_eip" "bastion" {
  vpc      = true
  instance = aws_instance.bastion.id

  tags = merge(
    { "Name" = var.name_prefix },
    var.tags,
  )
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.bastion.id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  source_dest_check           = false
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "20"
    delete_on_termination = true

    encrypted  = true
    kms_key_id = data.aws_kms_alias.ebs.target_key_arn
  }

  tags = merge(
    { "Name" = var.name_prefix },
    var.tags,
  )

  volume_tags = merge(
    { "Name" = var.name_prefix },
    var.tags,
  )
}
