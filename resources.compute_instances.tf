variable "vms_config" {
  type = map(object({
    os_type     = string
    platform_id = string

    is_preemptible = bool

    resources = object({
      cores         = number
      memory        = number
      core_fraction = number
    })

    initialize_params = object({
      size = number
      type = string
    })

    network_interface = object({
      is_nat = bool
    })
  }))

  default = {
    "rocky-clickhouse" = {
      os_type     = "rocky"
      platform_id = "standard-v3"

      is_preemptible = true

      resources = {
        cores         = 2
        memory        = 2
        core_fraction = 20
      }

      initialize_params = {
        size = 10
        type = "network-hdd"
      }

      network_interface = {
        is_nat = true
      }
    }

    "ubuntu-clickhouse" = {
      os_type     = "ubuntu"
      platform_id = "standard-v3"

      is_preemptible = true

      resources = {
        cores         = 2
        memory        = 2
        core_fraction = 20
      }

      initialize_params = {
        size = 10
        type = "network-hdd"
      }

      network_interface = {
        is_nat = true
      }
    }
  }
}

# ---

data "yandex_compute_image" "rocky_img" {
  family = "rocky-9-oslogin"
}

data "yandex_compute_image" "ubuntu_img" {
  family = "ubuntu-2204-lts"
}

# ---

locals {
  map_imgs = {
    rocky  = data.yandex_compute_image.rocky_img.id
    ubuntu = data.yandex_compute_image.ubuntu_img.id
  }
  map_ids = {
    rocky  = ["rocky", tls_private_key.rocky_id.public_key_openssh, var.rocky_id_name]
    ubuntu = ["ubuntu", tls_private_key.ubuntu_id.public_key_openssh, var.ubuntu_id_name]
  }
}

resource "yandex_compute_instance" "clickhouse" {
  for_each = var.vms_config

  zone        = yandex_vpc_subnet.subnet.zone
  platform_id = each.value.platform_id

  name     = each.key
  hostname = each.key

  resources {
    cores         = each.value.resources.cores
    memory        = each.value.resources.memory
    core_fraction = each.value.resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = local.map_imgs[each.value.os_type]
      size     = each.value.initialize_params.size
      type     = each.value.initialize_params.type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = each.value.network_interface.is_nat
  }

  metadata = {
    ssh-keys = "${local.map_ids[each.value.os_type][0]}:${local.map_ids[each.value.os_type][1]}"
  }
}
