resource "google_artifact_registry_repository" "gke_gitops_images" {
  location      = var.region
  repository_id = "gke-gitops-images"
  description   = "Docker images for the GKE GitOps assignment"
  format        = "DOCKER"

  depends_on = [google_project_service.required]
}
