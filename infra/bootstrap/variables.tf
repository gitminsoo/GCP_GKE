variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Default GCP region"
  type        = string
  default     = "asia-northeast3"
}

variable "state_bucket_name" {
  description = "GCS bucket name for Terraform remote state"
  type        = string
}
