terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# DNS Zone for demo.kubenfv.io
resource "google_dns_managed_zone" "demo_zone" {
  name        = var.dns_zone_name
  dns_name    = var.dns_name
  description = "DNS zone for kubenfv demo environment"

  labels = {
    environment = "demo"
    project     = "kubenfv"
  }
}

# Static IP for the VM
resource "google_compute_address" "demo_static_ip" {
  name   = var.static_ip_name
  region = var.region
}

# VM Instance
resource "google_compute_instance" "demo_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["demo", "kubenfv"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = var.disk_size
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.demo_static_ip.address
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  labels = {
    environment = "demo"
    project     = "kubenfv"
  }
}

# DNS A record for wildcard *.demo.kubenfv.io
resource "google_dns_record_set" "wildcard_a_record" {
  name = "*.${var.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.demo_zone.name

  rrdatas = [google_compute_address.demo_static_ip.address]
}

# Firewall rules for common services
resource "google_compute_firewall" "demo_firewall" {
  name    = var.firewall_rule_name
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080", "8443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["demo", "kubenfv"]
}
