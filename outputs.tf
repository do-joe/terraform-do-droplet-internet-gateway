output "igw_private_ips" {
  description = "Private IP addresses for the IGW droplets"
  value       = [for d in digitalocean_droplet.igw : d.ipv4_address_private]
}