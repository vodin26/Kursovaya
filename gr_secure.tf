#Bastion ssh & ping
resource "yandex_vpc_security_group" "secure_port_sg" {
  name        = "secure-port-sg"
  description = "ping & ssh"
  network_id  = yandex_vpc_network.external_network.id

  egress {
    protocol       = "ANY"
    description    = "any out"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "rule external ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "ICMP"
    description    = "in icmp"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 8
  }

  egress {
    protocol       = "ICMP"
    description    = "out icmp"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 8
    to_port        = 8
  }

}

#Balancer HTTP
resource "yandex_vpc_security_group" "internal_balancer_sg" {
  name        = "internal-bastion-sg"
  description = "HTTP 80 & 30000 port"
  network_id  = yandex_vpc_network.external_network.id

  egress {
    protocol       = "ANY"
    description    = "any out"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "rule-external-HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol          = "TCP"
    description       = "Healthchecks"
    v4_cidr_blocks    = ["0.0.0.0/0"]
    predefined_target = "loadbalancer_healthchecks"
    port              = 30000
  }

}

#Subnets
resource "yandex_vpc_security_group" "inside_subnet" {
  name       = "inside-subnet"
  network_id = yandex_vpc_network.external_network.id
  ingress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

#Zabbix
resource "yandex_vpc_security_group" "zabbix_sg" {
  name       = "zabbix-sg"
  network_id = yandex_vpc_network.external_network.id

  egress {
    protocol       = "ANY"
    description    = "any out"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "allow zabbix connections from internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 8080
  }

  ingress {
    protocol       = "TCP"
    description    = "zabbix-agent"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 10050
  }
  ingress {
    protocol       = "TCP"
    description    = "zabbix-agent"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 10051
  }
}

#Kibana
resource "yandex_vpc_security_group" "kibana_sg" {
  name        = "kibana-sg"
  description = "Разрешение на подключение к kibana из сети Интернет"
  network_id  = yandex_vpc_network.external_network.id

  egress {
    protocol       = "ANY"
    description    = "allow any outgoing connection"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "allow kibana connections from internet"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5601
  }

  ingress {
    protocol       = "TCP"
    description    = "allow ping"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

}
