# Production VPC
resource "google_compute_network" "production-vpc" {
  name                    = "production-vpc"
  auto_create_subnetworks = false
}

# Public subnets
resource "google_compute_subnetwork" "public-subnet-1" {
  name          = "public-subnet-1"
  ip_cidr_range = var.public_subnet_1_cidr
  network       = google_compute_network.production-vpc.self_link
  region        = var.region
}
resource "google_compute_subnetwork" "public-subnet-2" {
  name          = "public-subnet-2"
  ip_cidr_range = var.public_subnet_2_cidr
  network       = google_compute_network.production-vpc.self_link
  region        = var.region
}

# Private subnets
resource "google_compute_subnetwork" "private-subnet-1" {
  name          = "private-subnet-1"
  ip_cidr_range = var.private_subnet_1_cidr
  network       = google_compute_network.production-vpc.self_link
  region        = var.region
}
resource "google_compute_subnetwork" "private-subnet-2" {
  name          = "private-subnet-2"
  ip_cidr_range = var.private_subnet_2_cidr
  network       = google_compute_network.production-vpc.self_link
  region        = var.region
}

# Route tables for the subnets
# GCP automatically creates route tables for each subnet, so no explicit resource needed.

# Associate the newly created route tables to the subnets
# GCP subnets are automatically associated with the appropriate route table, no explicit resource needed.

# Cloud NAT
resource "google_compute_router_nat" "nat-gw" {
  name         = "nat-gw"
  router       = google_compute_network.production-vpc.self_link
  nat_ip_allocate_option = "MANUAL_ONLY" # This option only allocates IP addresses for manual NATs. Needed for using existing IP address (Elastic IP equivalent).
}

# Internet Gateway for the public subnet
# GCP does not have an Internet Gateway equivalent. Outgoing traffic is routed through Cloud NAT.

# Route the public subnet traffic through the Cloud NAT
# GCP automatically routes traffic through Cloud NAT for instances without an external IP address.

# Elastic IP (Static IP in GCP)
resource "google_compute_address" "elastic-ip-for-nat-gw" {
  name   = "elastic-ip-for-nat-gw"
  region = var.region
}

# Associate static IP with Cloud NAT
resource "google_compute_router_nat_ip" "nat-gw-ip" {
  router     = google_compute_router_nat.nat-gw.name
  region     = var.region
  nat_router = google_compute_router_nat.nat-gw.self_link
  nat_ip     = google_compute_address.elastic-ip-for-nat-gw.address
}
