resource "yandex_compute_instance" "bastion-host" {
  name        = "bastion-host"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pbf0hl06ks8s3scqk"
      size     = 10
    }
  }


  network_interface {
    subnet_id          = yandex_vpc_subnet.external_subnet.id
    nat                = true
    nat_ip_address     = yandex_vpc_address.bastion_address.external_ipv4_address.0.address
    security_group_ids = [yandex_vpc_security_group.secure-port-sg.id]
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.internal_subnet.id
    nat_ip_address     = "172.16.15.254"
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id]
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}




