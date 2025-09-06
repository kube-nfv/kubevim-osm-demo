output "dns_zone_name_servers" {
  description = "Name servers for the DNS zone"
  value       = google_dns_managed_zone.demo_zone.name_servers
}

output "instance_public_ip" {
  description = "Public IP address of the VM instance"
  value       = google_compute_address.demo_static_ip.address
}

output "instance_name" {
  description = "Name of the VM instance"
  value       = google_compute_instance.demo_instance.name
}

output "dns_zone_name" {
  description = "DNS zone name"
  value       = google_dns_managed_zone.demo_zone.name
}

output "dns_name" {
  description = "DNS domain name"
  value       = google_dns_managed_zone.demo_zone.dns_name
}