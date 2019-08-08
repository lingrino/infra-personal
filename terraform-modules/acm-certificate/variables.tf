variable "domain_name" {
  type        = string
  description = "The primary domain name for the certificate. Ex: 'www.example.com'"
}

variable "zone_name" {
  type        = string
  description = "The zone name for the primary domain name for the certificate. Ex: 'example.com'"
}

variable "sans_domain_names_to_zone_names" {
  type        = map(string)
  description = "A map of FQDNs to their Route53 Zone names representing SANs that this site should be accessible at. Ex: ['example.com' => 'example.com', 'foo.example.com' => 'foo.example.com', '*.bar.example.com' => 'bar.example.com']"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}
