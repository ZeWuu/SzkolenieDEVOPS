resource "tls_private_key" "main" {
  algorithm = "ED25519"
}

resource "digitalocean_ssh_key" "main" {
  name       = local.ssh_key_name
  public_key = trimspace(tls_private_key.main.public_key_openssh)
}

resource "local_sensitive_file" "ssh_private_key" {
  filename             = "${path.module}/artefacts/${local.name}-id_ed25519"
  content              = tls_private_key.main.private_key_openssh
  file_permission      = "0600"
  directory_permission = "0700"
}

resource "local_file" "ssh_public_key" {
  filename             = "${path.module}/artefacts/${local.name}-id_ed25519.pub"
  content              = "${trimspace(tls_private_key.main.public_key_openssh)}\n"
  file_permission      = "0644"
  directory_permission = "0700"
}