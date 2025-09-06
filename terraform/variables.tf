variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-central2"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "europe-central2-a"
}

variable "dns_zone_name" {
  description = "DNS zone name"
  type        = string
  default     = "demo-kubenfv-io"
}

variable "dns_name" {
  description = "DNS domain name"
  type        = string
  default     = "demo.kubenfv.io."
}

variable "instance_name" {
  description = "VM instance name"
  type        = string
  default     = "kubenfv-demo"
}

variable "machine_type" {
  description = "VM machine type"
  type        = string
  default     = "e2-standard-4"
}

variable "disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 100
}

variable "static_ip_name" {
  description = "Static IP address name"
  type        = string
  default     = "demo-static-ip"
}

variable "firewall_rule_name" {
  description = "Firewall rule name"
  type        = string
  default     = "kubenfv-demo-firewall"
}

variable "ssh_user" {
  description = "SSH username"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}