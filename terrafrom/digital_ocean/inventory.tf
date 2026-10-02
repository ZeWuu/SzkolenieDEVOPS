# Dane połączenia pochodzą z zasobów zarządzanych w tym samym stanie.
resource "local_file" "ansible_inventory" {
  filename             = "${path.module}/artefacts/inventory.yml"
  file_permission      = "0600"
  directory_permission = "0700"
  content = yamlencode({
    all = {
      children = {
        ubuntu = {
          hosts = {
            "ubuntu-web-01" = {
              ansible_host                 = digitalocean_droplet.this.ipv4_address
              ansible_user                 = "root"
              ansible_ssh_private_key_file = abspath(local_sensitive_file.ssh_private_key.filename)
              ansible_python_interpreter   = "/usr/bin/python3"
            }
          }
        }
      }
    }
  })
}

output "ansible_inventory_file" {
  description = "Inventory Ansible wygenerowane z adresu Dropleta i ścieżki klucza SSH."
  value       = abspath(local_file.ansible_inventory.filename)
}

output "application_url" {
  description = "Strona Nginx; aplikacja jest dostępna po wykonaniu Ansible."
  value       = "http://${digitalocean_droplet.this.ipv4_address}/"
}
