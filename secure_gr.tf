resource "yandex_vpc_security_group" "secure-port-sg" {
  name        = "secure-port-sg"
  description = "security port group"
  network_id  = yandex_vpc_network.external_network.id

  ingress {
    protocol       = "TCP"
    description    = "rule external ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

resource "yandex_vpc_security_group" "internal-bastion-sg" {
  name        = "internal-bastion-sg"
  description = "internal security group"
  network_id  = yandex_vpc_network.internal_network.id

  ingress {
    protocol       = "TCP"
    description    = "for ssh"
    v4_cidr_blocks = ["172.16.16.254/32"]
    port           = 22
  }

  egress {
    protocol       = "TCP"
    description    = "for ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 22
    to_port        = 22
  }

}

