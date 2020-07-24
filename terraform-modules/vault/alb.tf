resource "aws_lb" "vault" {
  name_prefix        = "${var.name_prefix}-"
  internal           = true
  load_balancer_type = "application"
  enable_http2       = true
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.alb_subnets

  access_logs {
    enabled = true
    bucket  = aws_s3_bucket.logs.id
    prefix  = "alb-access-logs"
  }

  tags = merge(
    { "Name" = var.name_prefix },
    var.tags,
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.vault.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.vault.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vault.arn
  }
}

resource "aws_lb_target_group" "vault" {
  name_prefix = "${var.name_prefix}-"
  port        = "8200"
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id

  deregistration_delay = "10"

  # /sys/health will return 200 only if the vault instance
  # is the leader. Meaning there will only ever be one healthy
  # instance, but a failure will cause a new instance to
  # be healthy automatically. This healthceck path prevents
  # unnecessary redirect loops by not sending traffic to
  # followers, which always just route traffic to the leader
  health_check {
    path                = "/v1/sys/health"
    port                = "8200"
    protocol            = "HTTPS"
    interval            = "5"
    timeout             = "3"
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    matcher             = "200"
  }

  tags = merge(
    { "Name" = var.name_prefix },
    var.tags,
  )
}
