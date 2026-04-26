resource "google_container_cluster" "ts_gke_cluster" {
  name     = "ts-gke-cluster"
  location = var.region

  enable_autopilot = true

  network    = google_compute_network.ts_vpc.name
  subnetwork = google_compute_subnetwork.ts_subnet_public_a.name

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  deletion_protection = false
}

