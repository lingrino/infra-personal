variable "zone_id" {
  type        = string
  description = "The hosted zone ID of the zone that will be doing the delegation"
}

variable "domain" {
  type        = string
  description = "The domain to delegate (ex: dev.example.com)"
}

variable "nameservers" {
  type        = set(string)
  description = "The list of nameservers of the route53 zone that we are delegating to"
}
