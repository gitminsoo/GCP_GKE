resource "google_container_cluster" "ms_gke_cluster" {
  name     = "ms-gke-cluster"
  location = var.region

  enable_autopilot = true

  network    = google_compute_network.ms_vpc.name
  subnetwork = google_compute_subnetwork.ms_subnet_public_a.name

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  deletion_protection = false
}
