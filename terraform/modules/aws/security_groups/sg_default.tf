resource "aws_default_security_group" "default" {
  vpc_id = "${ var.vpc_id }"

  tags = "${ merge(
    map(
      "Name",
      "DO_NOT_USE",
      "description",
      "default vpc security group, cannot be deleted",
    ),
    var.tags,
    module.constants.tags_default )
  }"
}
