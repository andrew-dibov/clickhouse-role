variable "rocky_id_name" {
  type    = string
  default = "rocky_id"
}

variable "ubuntu_id_name" {
  type    = string
  default = "ubuntu_id"
}

# ---

resource "tls_private_key" "rocky_id" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "ubuntu_id" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "rocky_private" {
  content         = tls_private_key.rocky_id.private_key_openssh
  filename        = "${path.module}/.auth/${var.rocky_id_name}"
  file_permission = "0600"
}

resource "local_file" "ubuntu_private" {
  content         = tls_private_key.ubuntu_id.private_key_openssh
  filename        = "${path.module}/.auth/${var.ubuntu_id_name}"
  file_permission = "0600"
}

resource "local_file" "rocky_public" {
  content  = tls_private_key.rocky_id.public_key_openssh
  filename = "${path.module}/.auth/${var.rocky_id_name}.pub"
}

resource "local_file" "ubuntu_public" {
  content  = tls_private_key.ubuntu_id.public_key_openssh
  filename = "${path.module}/.auth/${var.ubuntu_id_name}.pub"
}
