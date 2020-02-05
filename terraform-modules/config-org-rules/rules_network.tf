####################################
### EIP Utilized                 ###
####################################
resource "aws_config_organization_managed_rule" "eip_utilized" {
  name        = "eip_utilized"
  description = "Noncompliant when reserved elastic IPs are not attached to anything"

  rule_identifier = "EIP_ATTACHED"

  tags = merge(
    { "Name" = "eip_utilized" },
    var.tags
  )
}

#####################################
### VPC Default Security Group    ###
#####################################
resource "aws_config_organization_managed_rule" "vpc_default_security_group" {
  name        = "vpc_default_security_group"
  description = "Noncompliant when a default VPC security group is not 'closed' (doesn't allow in/out traffic)"

  rule_identifier = "VPC_DEFAULT_SECURITY_GROUP_CLOSED"

  tags = merge(
    { "Name" = "vpc_default_security_group" },
    var.tags
  )
}
