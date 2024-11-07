resource "yandex_vpc_security_group" "secure-bastion-sg" {
  name        = "secure-bastion-sg"
  description = "bastion security group"
  network_id  = yandex_vpc_network.external_bastion_network.id

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
  network_id  = yandex_vpc_network.internal_bastion_network.id

  ingress {
    protocol       = "TCP"
    description    = "for incoming traffic on the bastion host"
    v4_cidr_blocks = ["172.16.16.254/32"]
    port           = 22
  }

  egress {
    protocol       = "TCP"
    description    = "for incoming traffic coming from the bastion host"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 22
    to_port        = 22
  }

}

