#Bastion
resource "yandex_compute_instance" "bastion-host" {
  name        = "bastion-host"
  hostname    = "bastion-host"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

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

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.bastion_subnet.id
    nat                = true
    ip_address         = "172.16.18.10"
    security_group_ids = [yandex_vpc_security_group.secure-port-sg.id, yandex_vpc_security_group.inside_subnet.id]
  }
  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}

#vm-a
resource "yandex_compute_instance" "vm-a" {
  name                      = "vm-a"
  hostname                  = "vm-a"
  zone                      = "ru-central1-a"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }


  network_interface {
    subnet_id          = yandex_vpc_subnet.internal_subnet-a.id
    nat                = false
    ip_address         = "172.16.15.10"
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id, yandex_vpc_security_group.inside_subnet.id]
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

#vm-b
resource "yandex_compute_instance" "vm-b" {
  name        = "vm-b"
  hostname    = "vm-b"
  zone        = "ru-central1-b"
  platform_id = "standard-v3"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }


  network_interface {
    subnet_id          = yandex_vpc_subnet.internal_subnet-b.id
    nat                = false
    ip_address         = "172.16.16.10"
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id, yandex_vpc_security_group.inside_subnet.id]
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

#Zabbix
resource "yandex_compute_instance" "zabbix" {
  name        = "zabbix"
  hostname    = "zabbix"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

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

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.internal_subnet-lb.id
    nat                = true
    ip_address         = "172.16.17.10"
    security_group_ids = [yandex_vpc_security_group.zabbix-sg.id, yandex_vpc_security_group.inside_subnet.id]
  }
  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}

#Kibana
resource "yandex_compute_instance" "kibana" {
  name        = "kibana"
  hostname    = "kibana"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

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

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.internal_subnet-lb.id
    nat                = true
    ip_address         = "172.16.17.11"
    security_group_ids = [yandex_vpc_security_group.zabbix-sg.id, yandex_vpc_security_group.inside_subnet.id]
  }
  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}

#elasticsearch
resource "yandex_compute_instance" "elasticsearch" {
  name        = "elasticsearch"
  hostname    = "elasticsearch"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

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

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.internal_subnet-lb.id
    nat                = true
    ip_address         = "172.16.17.12"
    security_group_ids = [yandex_vpc_security_group.zabbix-sg.id, yandex_vpc_security_group.inside_subnet.id]
  }
  metadata = {
    user-data = "${file("./meta.yaml")}"
  }
}