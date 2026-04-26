variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Default GCP region"
  type        = string
  default     = "asia-northeast3"
}

variable "zone_a" {
  description = "Primary zone"
  type        = string
  default     = "asia-northeast3-a"
}

variable "zone_c" {
  description = "Secondary zone"
  type        = string
  default     = "asia-northeast3-c"
}

variable "github_owner" {
  description = "GitHub user or organization that owns the repository"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
  default     = "gcp_assign"
}

