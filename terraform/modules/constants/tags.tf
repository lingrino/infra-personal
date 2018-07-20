output "tags_default" {
  value = {
    terraform = "true"
  }
}

output "tags_default_asg" {
  value = [{
    key                 = "terraform"
    value               = true
    propagate_at_launch = true
  }]
}
