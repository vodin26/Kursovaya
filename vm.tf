resource "yandex_compute_instance" "vm-a" {
  name        = "vm-a"
  zone        = "ru-central1-a"
  platform_id = "standard-v3"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }


  network_interface {
    subnet_id          = yandex_vpc_subnet.bastion_internal_segment.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id]
  }

  scheduling_policy {
    preemptible = true
  }



  boot_disk {
    initialize_params {
      image_id = "fd8pbf0hl06ks8s3scqk"
      size     = 10
    }
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"
  }

}

resource "yandex_compute_instance" "vm-b" {
  name        = "vm-a"
  zone        = "ru-central1-b"
  platform_id = "standard-v3"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }


  network_interface {
    subnet_id          = yandex_vpc_subnet.bastion_internal_segment.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id]
  }

  scheduling_policy {
    preemptible = true
  }



  boot_disk {
    initialize_params {
      image_id = "fd8pbf0hl06ks8s3scqk"
      size     = 10
    }
  }

  metadata = {
    user-data = "${file("./meta.yaml")}"
  }

}
