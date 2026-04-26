output "state_bucket_name" {
  description = "Created GCS bucket name for Terraform remote state"
  value       = google_storage_bucket.terraform_state.name
}
