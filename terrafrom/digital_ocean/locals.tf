locals {
  name            = "${var.name_prefix}-${random_id.suffix.hex}"
  firewall_config = yamldecode(file("${path.module}/firewall.yml"))
}
