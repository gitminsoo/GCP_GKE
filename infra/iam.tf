resource "google_service_account" "ms_gke_sa" {
  account_id   = "ms-gke-sa"
  display_name = "MS GKE Node Service Account"
  description  = "Least-privilege service account for GKE nodes"
}

resource "google_project_iam_member" "ms_gke_sa_log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.ms_gke_sa.email}"
}

resource "google_project_iam_member" "ms_gke_sa_metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.ms_gke_sa.email}"
}

resource "google_project_iam_member" "ms_gke_sa_artifact_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.ms_gke_sa.email}"
}
