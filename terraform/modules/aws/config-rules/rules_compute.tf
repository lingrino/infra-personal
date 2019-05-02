####################################
### EC2 Detailed Monitoring      ###
####################################
resource "aws_config_config_rule" "ec2_detailed_monitoring" {
  name        = "ec2_detailed_monitoring"
  description = "Noncompliant when detailed monitoring on EC2 instances is not enabled"

  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_DETAILED_MONITORING_ENABLED"
  }
}

####################################
### EC2 in VPC                   ###
####################################
resource "aws_config_config_rule" "ec2_in_vpc" {
  name        = "ec2_in_vpc"
  description = "Noncompliant when EC2 instances are not in a VPC"

  source {
    owner             = "AWS"
    source_identifier = "INSTANCES_IN_VPC"
  }
}

####################################
### ELB Logging                  ###
####################################
resource "aws_config_config_rule" "elb_logging" {
  name        = "elb_logging"
  description = "Noncompliant when load balancers do not have logging enabled"

  source {
    owner             = "AWS"
    source_identifier = "ELB_LOGGING_ENABLED"
  }
}
