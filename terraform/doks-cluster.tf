terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}


resource "digitalocean_kubernetes_cluster" "test-cluster" {
  name   = "ks-test-cluster"
  region = "sfo2"
  auto_upgrade = true
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.21.3-do.0"

  node_pool {
    name       = "node"
    size       = "s-2vcpu-2gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 3
  }
}

