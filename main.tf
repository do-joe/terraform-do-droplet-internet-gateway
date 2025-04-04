terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.50"
    }
    kubernetes = {
    source  = "hashicorp/kubernetes"
    version = ">= 2.0"
  }
  }
}

resource "digitalocean_droplet" "igw" {
  count   = var.igw_count
  name    = "${var.name_prefix}-${var.region}-igw-${count.index}"
  region  = var.region
  size    = var.size
  image   = var.image
  monitoring = var.monitoring
  vpc_uuid = var.vpc_id
  ssh_keys = var.ssh_keys
  tags = var.tags
  user_data = file("${path.module}/cloud-init.yaml")
}

data "digitalocean_kubernetes_cluster" "doks_cluster" {
  name = var.doks_cluster_name
}

provider "kubernetes" {
  host  = data.digitalocean_kubernetes_cluster.doks_cluster.endpoint
  token = data.digitalocean_kubernetes_cluster.doks_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.doks_cluster.kube_config[0].cluster_ca_certificate
  )
}

resource "kubernetes_manifest" "doks_route" {
  manifest = {
    apiVersion = "networking.doks.digitalocean.com/v1alpha1"
    kind       = "Route"
    metadata = {
      name = "default"
    }
    spec = {
      destinations = ["0.0.0.0/0"]
      gateways     = [for d in digitalocean_droplet.igw : d.ipv4_address_private]
    }
  }
}



