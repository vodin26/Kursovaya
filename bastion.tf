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
      image_id = "fd8pbf0hl06ks8s3scqk" #"fd816n2u2s4ob8p8dttv"
      size     = 10
    }
  }


  network_interface {
    subnet_id          = yandex_vpc_subnet.bastion_external_segment.id
    nat                = true
    nat_ip_address     = yandex_vpc_address.bastion_address.external_ipv4_address.0.address
    security_group_ids = [yandex_vpc_security_group.secure-bastion-sg.id]
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.bastion_internal_segment.id
    nat_ip_address     = "172.16.16.254"
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id]
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}




