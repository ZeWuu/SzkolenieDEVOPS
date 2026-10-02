resource "digitalocean_droplet" "main" {
  count = 1
  name = var.droplet_name
  image = var.droplet_image
  size = var.droplet_size
  region = var.region
  backups = false
  monitoring = false
  ipv6 = false
  vpc_uuid = digitalocean_vpc.main.id
  ssh_keys = [digitalocean_ssh_key.main.id]
  tags = [ "testserver"]
  user_data = null
  droplet_agent = false
}


resource "digitalocean_vpc" "main" {
    name = var.vpc_name
    region = var.region
    ip_range = var.vpc_ip_range
    description = "This is a VPC for ${var.vpc_name} test purposes"
}

resource "digitalocean_firewall" "main" {
  name = var.firewall_name
  droplet_ids = [digitalocean_droplet.main[0].id]

  dynamic "inbound_rule" {
    for_each = local.firewall_configuration.inbound
    content {
      protocol = inbound_rule.value.protocol
      port_range = inbound_rule.value.port_range
      source_addresses = inbound_rule.value.source_addresses
    }
  }

  dynamic "outbound_rule" {
    for_each = local.firewall_configuration.outbound
    content {
      protocol = outbound_rule.value.protocol
      port_range = outbound_rule.value.port_range
      destination_addresses = outbound_rule.value.destination_addresses
    }
  }
}

resource "digitalocean_ssh_key" "main" {
  name = var.ssh_key_name
  public_key = tls_private_key.main.public_key_openssh
}

resource "tls_private_key" "main" {
    algorithm = "ED25519"
}