variable "vpc_net_name" {
  type    = string
  default = "clickhouse-net"
}

variable "vpc_subnet_name" {
  type    = string
  default = "clickhouse-subnet"
}

variable "vpc_subnet_cidr" {
  type    = list(string)
  default = ["10.10.10.0/24"]
}

# ---

resource "yandex_vpc_network" "net" {
  name = var.vpc_net_name
}

resource "yandex_vpc_subnet" "subnet" {
  network_id     = yandex_vpc_network.net.id
  zone           = var.yc_zone_id
  name           = var.vpc_subnet_name
  v4_cidr_blocks = var.vpc_subnet_cidr
}
