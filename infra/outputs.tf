output "vpc_name" {
  description = "Created VPC name"
  value       = google_compute_network.ms_vpc.name
}

output "gke_cluster_name" {
  description = "Created GKE cluster name"
  value       = google_container_cluster.ms_gke_cluster.name
}

output "gke_cluster_endpoint" {
  description = "GKE control plane endpoint"
  value       = google_container_cluster.ms_gke_cluster.endpoint
  sensitive   = true
}

output "gke_sa_email" {
  description = "GKE node service account email"
  value       = google_service_account.ms_gke_sa.email
}

output "artifact_registry_repository" {
  description = "Artifact Registry repository name"
  value       = google_artifact_registry_repository.gke_gitops_images.name
}

output "github_actions_service_account" {
  description = "Service account used by GitHub Actions"
  value       = google_service_account.github_actions_deploy.email
}

output "workload_identity_provider" {
  description = "GitHub Actions Workload Identity Provider resource name"
  value       = google_iam_workload_identity_pool_provider.github_provider.name
}
