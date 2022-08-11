variable "cloudflare_account_id" {
  type        = string
  description = "cloudflare account ID to create the resources in"
}

variable "domain" {
  type        = string
  description = "The domain to create the zone for"
}

variable "enable_argo" {
  type        = bool
  description = "Whether or not to enable argo (requries initial confirmation in UI)"
  default     = false
}

variable "enable_caching" {
  type        = bool
  description = "Whether or not to enable cloudflare caching features for the zone (first update content policies)."
  default     = true
}

variable "enable_gsuite" {
  type        = bool
  description = "Whether or not to enable gsuite domain verification"
  default     = false
}

variable "gsuite_dkim_value" {
  type        = string
  description = "The value of your gsuite dkim record. Prefix must be google."
  default     = ""
}

variable "google_site_verifications" {
  type        = list(string)
  description = "An optional list of google site verification strings"
  default     = []
}

variable "verify_ses" {
  type        = bool
  description = "Default true. Whether or not to create a domain in SES and verify it"
  default     = true
}

variable "ses_region" {
  type        = string
  description = "Default us-east-1. The region to verify SES in"
  default     = "us-east-1"
}

variable "ses_sns_arn" {
  type        = string
  description = "An SNS ARN to send SNS bounce, complaint, and delivery events to"
  default     = ""
}

variable "keybase_record_value" {
  type        = string
  description = "An optional keybase verification string, starts with keybase-site-verification="
  default     = ""
}

variable "github_record_value" {
  type        = string
  description = "An optional github verification string"
  default     = ""
}

variable "skip_ns" {
  type        = bool
  description = "set true to skip creating ns records in the zone"
  default     = false
}
