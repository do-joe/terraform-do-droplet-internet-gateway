terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.50"
    }
  }
}

resource "digitalocean_droplet" "intet_gw" {
  name    = "${var.name_prefix}-${var.region}-igw${var.name_suffix}"
  region  = var.region
  size    = var.size
  image   = var.image
  monitoring = var.monitoring
  vpc_uuid = var.vpc_id
  ssh_keys = var.ssh_keys
  tags = var.tags
  user_data = file("${path.module}/cloud-init.yaml")
}