resource "digitalocean_firewall" "this" {
  name        = "${local.name}-firewall"
  droplet_ids = [digitalocean_droplet.this.id]

  dynamic "inbound_rule" {
    for_each = local.firewall_config.inbound_rules

    content {
      protocol         = inbound_rule.value.protocol
      port_range       = try(inbound_rule.value.port_range, null)
      source_addresses = inbound_rule.value.source_addresses
    }
  }

  dynamic "outbound_rule" {
    for_each = local.firewall_config.outbound_rules

    content {
      protocol              = outbound_rule.value.protocol
      port_range            = try(outbound_rule.value.port_range, null)
      destination_addresses = outbound_rule.value.destination_addresses
    }
  }
}
