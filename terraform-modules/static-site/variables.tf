variable "name_prefix" {
  type        = string
  description = "A prefix to prepend to all 'Name' tags"
}

variable "domain_name" {
  type        = string
  description = "The primary domain name for the distribution. Ex: 'www.example.com'"
}

variable "zone_name" {
  type        = string
  description = "The zone name for the primary domain name for the distribution. Ex: 'example.com'"
}

variable "sans_domain_names_to_zone_names" {
  type        = map(string)
  description = "A map of FQDNs to their Route53 Zone names representing SANs that this distribution should be accessible at. Ex: ['example.com' => 'example.com', 'foo.example.com' => 'foo.example.com', '*.bar.example.com' => 'bar.example.com']"
}

variable "bucket_logs_domain" {
  type        = string
  description = "The domain of the S3 bucket to write logs to"
}

variable "healthcheck_cloudfront_enabled" {
  type        = string
  description = "Whether or not to run a healthcheck against the default cloudfront domain"
  default     = true
}

variable "healthcheck_domains_enabled" {
  type        = string
  description = "Whether or not to run a healthcheck against ALL domain names pointing to the cloudfront"
  default     = false
}

variable "healthcheck_sns_arn" {
  type        = string
  description = "The ARN of the SNS topic to notify when the configured healthcheck is unhealthy"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}
