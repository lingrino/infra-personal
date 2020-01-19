resource "aws_eip" "wg" {
  vpc = true

  tags = merge(
    { "Name" = var.name_prefix },
    var.tags,
  )
}

data "aws_ami" "wg" {
  owners           = [var.ami_owner_id]
  executable_users = ["self"]
  most_recent      = true
  name_regex       = "wireguard-*"
}

data "template_file" "userdata" {
  template = file("${path.module}/files/userdata.sh.j2")

  vars = {
    region        = data.aws_region.current.name
    allocation_id = aws_eip.wg.id
    bucket_name   = aws_s3_bucket.wg.id
    secret_arn    = aws_secretsmanager_secret.wg.arn
  }
}

resource "aws_launch_template" "wg" {
  name_prefix = "${var.name_prefix}-"

  image_id      = data.aws_ami.wg.id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(data.template_file.userdata.rendered)

  iam_instance_profile {
    name = aws_iam_instance_profile.wg.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      encrypted   = true
      volume_size = "20"
      volume_type = "gp2"
    }
  }

  network_interfaces {
    device_index                = 0
    associate_public_ip_address = true
    delete_on_termination       = true

    security_groups = [aws_security_group.wg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      { "Name" = var.name_prefix },
      var.tags,
    )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(
      { "Name" = var.name_prefix },
      var.tags,
    )
  }

  tags = merge(
    { "Name" = var.name_prefix },
    var.tags,
  )
}

resource "aws_autoscaling_group" "wg" {
  name_prefix = "${var.name_prefix}-"

  launch_template {
    id      = aws_launch_template.wg.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.subnets

  min_size         = 0
  max_size         = 1
  desired_capacity = 1

  health_check_type         = "EC2"
  health_check_grace_period = 300
  wait_for_capacity_timeout = 0
  termination_policies      = ["OldestInstance"]

  tags = [
    for k, v in merge({ "Name" = var.name_prefix }, var.tags) :
    { "key" : k, "value" : v, "propagate_at_launch" : "true" }
  ]
}
