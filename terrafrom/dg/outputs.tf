output "server_ip" {
  description = "Public IPv4 address of the Droplet"
  value       = digitalocean_droplet.main[0].ipv4_address
}

output "server_name" {
  description = "Droplet name"
  value       = digitalocean_droplet.main[0].name
}

output "vpc_id" {
  description = "VPC ID"
  value       = digitalocean_vpc.main.id
}

output "ssh_private_key_path" {
  description = "Path to generated private SSH key"
  value       = local_sensitive_file.ssh_private_key.filename
}

output "ssh_public_key_path" {
  description = "Path to generated public SSH key"
  value       = local_file.ssh_public_key.filename
}