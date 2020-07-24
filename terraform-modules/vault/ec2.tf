data "aws_ami" "vault" {
  owners      = [var.ami_owner_id]
  most_recent = true
  name_regex  = "vault-*"
}

data "template_file" "userdata" {
  template = file("${path.module}/files/userdata.sh")

  vars = {
    name_prefix = var.name_prefix
    region      = data.aws_region.current.name

    bucket_name_config = aws_s3_bucket.config.id
    vault_config_dir   = var.vault_config_dir
  }
}

resource "aws_launch_template" "vault" {
  name_prefix = "${var.name_prefix}-"

  image_id      = data.aws_ami.vault.id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(data.template_file.userdata.rendered)

  update_default_version = true

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2.name
  }

  network_interfaces {
    device_index = 0
    # associate_public_ip_address = false
    delete_on_termination = true

    security_groups = [aws_security_group.ec2.id]
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

resource "aws_autoscaling_group" "vault" {
  name_prefix = "${var.name_prefix}-"

  launch_template {
    id      = aws_launch_template.vault.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.ec2_subnets
  target_group_arns   = [aws_lb_target_group.vault.arn]

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  # Don't use ELB as the health check because we do not want
  # AWS to start cycling instances when Vault is unhealthy,
  # since our health check will only have one healthy at a time
  health_check_type = "EC2"

  health_check_grace_period = 300
  wait_for_capacity_timeout = 0
  termination_policies      = ["OldestInstance"]

  tags = [
    for k, v in merge({ "Name" = var.name_prefix }, var.tags) :
    { "key" : k, "value" : v, "propagate_at_launch" : "true" }
  ]
}

resource "aws_autoscaling_schedule" "up" {
  scheduled_action_name  = "${var.name_prefix}-up"
  autoscaling_group_name = aws_autoscaling_group.vault.name

  min_size         = aws_autoscaling_group.vault.min_size
  desired_capacity = aws_autoscaling_group.vault.desired_capacity + 1
  max_size         = aws_autoscaling_group.vault.max_size + 1

  recurrence = "0 9 * * *"
}

resource "aws_autoscaling_schedule" down {
  scheduled_action_name  = "${var.name_prefix}-down"
  autoscaling_group_name = aws_autoscaling_group.vault.name

  min_size         = aws_autoscaling_group.vault.min_size
  desired_capacity = aws_autoscaling_group.vault.desired_capacity
  max_size         = aws_autoscaling_group.vault.max_size

  recurrence = "5 9 * * *"
}
