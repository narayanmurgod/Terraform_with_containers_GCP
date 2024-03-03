# core

variable "region" {
  description = "The GCP region to create resources in."
  default     = "us-west1"
}

# networking

variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24" // Adjust CIDR block to fit GCP's requirements
}
variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24" // Adjust CIDR block to fit GCP's requirements
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24" // Adjust CIDR block to fit GCP's requirements
}
variable "private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24" // Adjust CIDR block to fit GCP's requirements
}
variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-west1-b", "us-west1-c"] // GCP does not have zones exactly like AWS, adjust as per GCP's regions/zones
}

# auto scaling

variable "autoscale_min" {
  description = "Minimum autoscale (number of instances)"
  default     = "1"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of instances)"
  default     = "2"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of instances)"
  default     = "2"
}

# load balancer

variable "health_check_path" {
  description = "Health check path for the default backend service"
  default     = "/ping/"
}

# logs

variable "log_retention_in_days" {
  default = 30 // Adjust as per GCP's logging service if applicable
}

# key pair

variable "ssh_pubkey_file" {
  description = "Path to an SSH public key"
  default     = "/path/to/your/gcp/ssh/key.pub"
}

# Compute Engine or Kubernetes Engine

variable "instance_type" {
  default = "n1-standard-1" // Adjust instance type as per GCP's offerings
}
variable "docker_image_url_django" {
  description = "Docker image to run in the GCP environment"
  default     = "gcr.io/your-project-id/django-app:latest" // Modify to fit GCR URL for your Docker image
}
variable "app_count" {
  description = "Number of Docker containers to run"
  default     = 2
}
