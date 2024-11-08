resource "yandex_vpc_network" "external_network" {
  name = "external-network"
}

resource "yandex_vpc_subnet" "external_subnet" {
  name           = "external-subnet"
  network_id     = yandex_vpc_network.external_network.id
  v4_cidr_blocks = ["172.16.17.0/28"]
  zone = "ru-central1-b"
}


resource "yandex_vpc_network" "internal_network" {
  name = "internal-network"
}

resource "yandex_vpc_subnet" "internal_subnet" {
  name           = "internal-subnet"
  network_id     = yandex_vpc_network.internal_network.id
  v4_cidr_blocks = ["172.16.16.0/24"]
  zone = "ru-central1-b"
}

resource "yandex_vpc_address" "bastion_address" {
  name = "bastion_address"

  external_ipv4_address {
     zone_id = "ru-central1-b"
  }
}

