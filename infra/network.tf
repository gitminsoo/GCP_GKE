resource "google_compute_network" "ms_vpc" {
  name                    = "ms-vpc"
  auto_create_subnetworks = false
  description             = "VPC for GKE GitOps assignment"

  depends_on = [google_project_service.required]
}

resource "google_compute_subnetwork" "ms_subnet_public_a" {
  name                     = "ms-subnet-public-a"
  ip_cidr_range            = "10.1.0.0/24"
  region                   = var.region
  network                  = google_compute_network.ms_vpc.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.4.0.0/14"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.8.0.0/20"
  }
}

resource "google_compute_subnetwork" "ms_subnet_public_c" {
  name                     = "ms-subnet-public-c"
  ip_cidr_range            = "10.1.1.0/24"
  region                   = var.region
  network                  = google_compute_network.ms_vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "ms_subnet_private_a" {
  name                     = "ms-subnet-private-a"
  ip_cidr_range            = "10.1.2.0/24"
  region                   = var.region
  network                  = google_compute_network.ms_vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "ms_subnet_private_c" {
  name                     = "ms-subnet-private-c"
  ip_cidr_range            = "10.1.3.0/24"
  region                   = var.region
  network                  = google_compute_network.ms_vpc.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "ms_allow_ssh" {
  name    = "ms-allow-ssh"
  network = google_compute_network.ms_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ms-bastion"]
  description   = "Allow SSH to bastion-tagged instances"
}
