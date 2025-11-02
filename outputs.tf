output "instance_resource_id" {
  description = "VM instance ID"
  value       = google_compute_instance.web_vm.id
}

# output "instance_public_ipv4" {
#   description = "VM Public IPv4"
#   value       = google_compute_instance.web_vm.network_interface.0.access_config.0.nat_ip
# }