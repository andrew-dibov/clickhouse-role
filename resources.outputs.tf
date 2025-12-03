resource "local_file" "inventory" {
  content = templatefile("${path.module}/templates/inventory.ini.tftpl", {
    instances = {
      for name, instance in yandex_compute_instance.clickhouse :
      name => {
        name      = instance.name
        public_ip = instance.network_interface[0].nat_ip_address
        user      = var.vms_config[name].os_type
        ssh_key   = ".auth/${local.map_ids[var.vms_config[name].os_type][2]}"
      }
    }
  })
  filename = "${path.module}/inventory.ini"
}

resource "local_file" "inventory_molecule" {
  content = templatefile("${path.module}/templates/inventory.molecule.ini.tftpl", {
    instances = {
      for name, instance in yandex_compute_instance.clickhouse :
      name => {
        name      = instance.name
        public_ip = instance.network_interface[0].nat_ip_address
        user      = var.vms_config[name].os_type
        ssh_key   = ".auth/${local.map_ids[var.vms_config[name].os_type][2]}"
      }
    }
  })
  filename = "${path.module}/inventory.molecule.ini"
}
