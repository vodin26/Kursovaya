#External network
resource "yandex_vpc_network" "external_network" {
  name = "external-network"
}
#VMs subnet
resource "yandex_vpc_subnet" "internal_subnet-a" {
  name           = "internal-subnet-a"
  network_id     = yandex_vpc_network.external_network.id
  v4_cidr_blocks = ["172.16.15.0/24"]
  zone           = "ru-central1-a"
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "internal_subnet-b" {
  name           = "internal-subnet-b"
  network_id     = yandex_vpc_network.external_network.id
  v4_cidr_blocks = ["172.16.16.0/24"]
  zone           = "ru-central1-b"
  route_table_id = yandex_vpc_route_table.rt.id
}

#NAT-gateway"
resource "yandex_vpc_gateway" "nat_gateway" {
  folder_id = "b1g9a0ig1pg9lr4oc5ie"
  name      = "nat-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt" {
  folder_id  = "b1g9a0ig1pg9lr4oc5ie"
  name       = "nat-route-table"
  network_id = yandex_vpc_network.external_network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}
#Load Balanser subnet
resource "yandex_vpc_subnet" "internal_subnet-lb" {
  name           = "internal_subnet-lb"
  zone           = "ru-central1-d"
  v4_cidr_blocks = ["172.16.17.0/24"]
  network_id     = yandex_vpc_network.external_network.id
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_vpc_subnet" "bastion_subnet" {
  name           = "bastion-subnet"
  zone           = "ru-central1-d"
  v4_cidr_blocks = ["192.168.18.0/24"]
  network_id     = yandex_vpc_network.external_network.id

}

#Bastion ip
resource "yandex_vpc_address" "bastion_address" {
  name = "bastion_address"

  external_ipv4_address {
    zone_id = "ru-central1-d"
  }
}
