module "sgs_defaults" {
  source = "../../../../modules/aws/security_groups"

  vpc_id = "${ data.terraform_remote_state.vpc_us_east_2_main.vpc_id }"
  tags   = {}
}
