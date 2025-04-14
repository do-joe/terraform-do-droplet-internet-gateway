output "igw_private_ips" {
  value = [for d in digitalocean_droplet.igw : d.ipv4_address_private]
}