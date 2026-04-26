resource "google_compute_network" "ts_vpc" {
  name                    = "ts-vpc"
  auto_create_subnetworks = false
  description             = "VPC for GKE GitOps assignment"

  depends_on = [google_project_service.required]
}

resource "google_compute_subnetwork" "ts_subnet_public_a" {
  name                     = "ts-subnet-public-a"
  ip_cidr_range            = "10.1.0.0/24"
  region                   = var.region
  network                  = google_compute_network.ts_vpc.id
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

resource "google_compute_subnetwork" "ts_subnet_public_c" {
  name                     = "ts-subnet-public-c"
  ip_cidr_range            = "10.1.1.0/24"
  region                   = var.region
  network                  = google_compute_network.ts_vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "ts_subnet_private_a" {
  name                     = "ts-subnet-private-a"
  ip_cidr_range            = "10.1.2.0/24"
  region                   = var.region
  network                  = google_compute_network.ts_vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "ts_subnet_private_c" {
  name                     = "ts-subnet-private-c"
  ip_cidr_range            = "10.1.3.0/24"
  region                   = var.region
  network                  = google_compute_network.ts_vpc.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "ts_allow_ssh" {
  name    = "ts-allow-ssh"
  network = google_compute_network.ts_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ts-bastion"]
  description   = "Allow SSH to bastion-tagged instances"
}
