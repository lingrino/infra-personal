variable "name" {
  type        = string
  description = "bucket name"
}

variable "enable_request_metrics" {
  type        = bool
  description = "enable metrics at the root path"
  default     = false
}

variable "enable_logging" {
  type        = bool
  description = "enable access logging"
  default     = true
}

variable "enable_versioning" {
  type        = bool
  description = "enable versioning"
  default     = true
}

variable "enable_object_lock" {
  type        = bool
  description = "enable object lock"
  default     = false
}

variable "versioning_retention_days" {
  type        = number
  description = "days to retain object versions. negative value is forever"
  default     = -1
}

variable "enable_intelligent_tiering" {
  type        = bool
  description = "enable intelligent tiering"
  default     = true
}

variable "policy" {
  type        = string
  description = "custom bucket policy"
  default     = "{}"
}

variable "enable_cloudfront_access" {
  type        = bool
  description = "enable cloudfront object read access"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "additional tags to add to every resource"
  default     = {}
}
