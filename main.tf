variable "yc_cloud_id" {
  type = string
}

variable "yc_folder_id" {
  type = string
}

variable "yc_zone_id" {
  type = string
}

variable "tf_service_account_key_file_path" {
  type    = string
  default = ".auth/.auth.json"
}

# ---

terraform {
  required_version = "= 1.12.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "= 0.169.0"
    }
  }
}

provider "yandex" {
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.yc_zone_id
  service_account_key_file = file("${var.tf_service_account_key_file_path}")
}
