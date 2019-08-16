variable "domain_name" {
  type        = string
  description = "The name of the domain to delegate"
}

variable "zone_name" {
  type        = string
  description = "The name of the route53 zone to create delegation records in. Can leave blank if the same as var.domain_name"
  default     = ""
}

variable "enable_webmail_login_portal" {
  type        = string
  description = "Set to true to enable the fastmail login portal at mail.`var.domain_name`. Will not work for wildcard domains"
  default     = false
}
