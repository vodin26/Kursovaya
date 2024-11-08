#Внешняя сеть
resource "yandex_vpc_network" "external_network" {
  name = "external-network"
}

resource "yandex_vpc_subnet" "external_subnet_a" {
  name           = "external-subnet-a"
  network_id     = yandex_vpc_network.external_network.id
  v4_cidr_blocks = ["172.16.17.0/28"]
  zone           = "ru-central1-a"
}

resource "yandex_vpc_subnet" "external_subnet_b" {
  name           = "external-subnet-b"
  network_id     = yandex_vpc_network.external_network.id
  v4_cidr_blocks = ["172.16.17.0/28"]
  zone           = "ru-central1-b"
}

#Внутренняя сеть
resource "yandex_vpc_network" "internal_network" {
  name = "internal-network"
}

resource "yandex_vpc_subnet" "internal_subnet_a" {
  name           = "internal-subnet-a"
  network_id     = yandex_vpc_network.internal_network.id
  v4_cidr_blocks = ["172.16.16.0/24"]
  zone           = "ru-central1-a"
}

resource "yandex_vpc_subnet" "internal_subnet_b" {
  name           = "internal-subnet-b"
  network_id     = yandex_vpc_network.internal_network.id
  v4_cidr_blocks = ["172.16.16.0/24"]
  zone           = "ru-central1-b"
}

#NAT-шлюз
resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id = "b1g9a0ig1pg9lr4oc5ie"
  name      = "nat-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  folder_id  = "b1g9a0ig1pg9lr4oc5ie"
  name       = "nat-route-table"
  network_id = yandex_vpc_network.internal_network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

#Bastion ip
resource "yandex_vpc_address" "bastion_address" {
  name = "bastion_address"

  external_ipv4_address {
    zone_id = "ru-central1-b"
  }
}


