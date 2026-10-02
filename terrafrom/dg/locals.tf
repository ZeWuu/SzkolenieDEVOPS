locals {
  name          = var.name_prefix
  droplet_name  = "${var.name_prefix}-agent"
  vpc_name      = "${var.name_prefix}-vpc"
  firewall_name = "${var.name_prefix}-firewall"
  ssh_key_name  = "${var.name_prefix}-ssh"

  firewall_configuration = {
    inbound = [
      {
        protocol         = "tcp"
        port_range       = "22"
        source_addresses = ["0.0.0.0/0", "::/0"]
      },
      {
        protocol         = "tcp"
        port_range       = "80"
        source_addresses = ["0.0.0.0/0", "::/0"]
      }
    ]

    outbound = [
      {
        protocol              = "tcp"
        port_range            = "1-65535"
        destination_addresses = ["0.0.0.0/0", "::/0"]
      },
      {
        protocol              = "udp"
        port_range            = "1-65535"
        destination_addresses = ["0.0.0.0/0", "::/0"]
      }
    ]
  }
}