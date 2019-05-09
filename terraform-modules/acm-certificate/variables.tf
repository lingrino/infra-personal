variable "dns_names_to_zone_names" {
  type        = map(string)
  description = "A map of FQDNs to their Route53 Zone names that this site should be accessible at. Ex: ['example.com' => 'example.com', 'foo.example.com' => 'foo.example.com', '*.bar.example.com' => 'bar.example.com']"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}
