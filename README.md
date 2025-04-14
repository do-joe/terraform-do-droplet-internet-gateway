# terraform-do-droplet-internet-gateway

This module creates one or more droplets and configures them as [Internet gateways (IGW)](https://docs.digitalocean.com/products/networking/vpc/how-to/configure-droplet-as-gateway/). The module will optionally configure a DOKS cluster that has the Routing Agent installed to use the IGWs as the cluster's default route.

The IGW droplets will be named based on a specified `name_prefix` var along with the region and a serial number. Deploying two IGWs with name_prefix of `igw` in `nyc3` region would create two droplets: `igw-nyc3-0` and `igw-nyc3-1`.

These deployed IGWs will be configured with IP Forwarding and Masquerade enabled.

**Note:** Unfortunately, due to the way Terraform handles provider blocks, this module cannot be used to configure more than one DOKS cluster. If you need to configure multiple DOKS clusters, it's recommended to [manually configue the Routing Agent](https://docs.digitalocean.com/products/kubernetes/how-to/use-routing-agent/) using the values of the output `igw_private_ips` as the default gateway addresses.

# Example
```terraform
module "igw" {
  source            = "git@github.com:digitalocean/terraform-do-droplet-internet-gateway.git"
  name_prefix       = "igw"
  igw_count         = 2
  region            = "nyc3"
  size              = "c-2"
  image             = "ubuntu-24-04-x64"
  vpc_id            = "d6b0cb8a-07ea-40d6-9031-70a43d070000"
  ssh_keys          = [1234]
  tags              = ["igw", "nyc3"]
  doks_cluster_name = "nyc3-prod1"
}
```

