variable "cloudflare_account_id" {
  type        = string
  description = "cloudflare account ID to create the resources in"
}

variable "domain" {
  type        = string
  description = "The domain to create the zone for"
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
