resource "yandex_vpc_network" "external_bastion_network" {
  name = "external-bastion-network"
}

resource "yandex_vpc_subnet" "bastion_external_segment" {
  name           = "bastion-external-segment"
  network_id     = yandex_vpc_network.external_bastion_network.id
  v4_cidr_blocks = ["172.16.17.0/28"]
  zone = "ru-central1-b"
}


resource "yandex_vpc_network" "internal_bastion_network" {
  name = "internal-bastion-network"
}

resource "yandex_vpc_subnet" "bastion_internal_segment" {
  name           = "bastion-internal-segment"
  network_id     = yandex_vpc_network.internal_bastion_network.id
  v4_cidr_blocks = ["172.16.16.0/24"]
  zone = "ru-central1-b"
}

resource "yandex_vpc_address" "bastion_address" {
  name = "bastion_address"

  external_ipv4_address {
     zone_id = "ru-central1-b"
  }
}

