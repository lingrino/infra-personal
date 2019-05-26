variable "name_prefix" {
  type        = string
  description = "A prefix to prepend to all 'Name' tags"
}

variable "heroku_app_name" {
  type        = string
  description = "The name of the Heroku app. Must be globally unique"
}

variable "heroku_buildpacks" {
  type        = list
  description = "A list of Heroku buildpacks for the app"
}

variable "heroku_env_vars" {
  type        = map(string)
  description = "A map of environment variables to exist in your app"
}

# TODO - once the heroku provider is supported in 0.12 drop this variables and switch
# to using the app output
variable "heroku_app_domain" {
  type        = string
  description = "The domain for the app"
}


variable "dns_names_to_zone_names" {
  type        = map(string)
  description = "A map of FQDNs to their Route53 Zone names that this site should be accessible at. Ex: ['example.com' => 'example.com', 'foo.example.com' => 'foo.example.com', '*.bar.example.com' => 'bar.example.com']"
}

variable "bucket_logs_domain" {
  type        = string
  description = "The domain of the S3 bucket to write logs to"
}

variable "healthcheck_sns_arn" {
  type        = string
  description = "The ARN of the SNS topic to notify when the configured healthcheck is unhealthy"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}
