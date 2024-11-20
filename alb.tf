resource "yandex_alb_load_balancer" "load_balancer" {
  name               = "load-balancer"
  network_id         = yandex_vpc_network.external_network.id
  security_group_ids = [yandex_vpc_security_group.inside_subnet.id, yandex_vpc_security_group.internal_balancer_sg.id]

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.internal_subnet_a.id
    }

    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.internal_subnet_b.id
    }

  }

  listener {
    name = "frontend-listener"
    endpoint {
      address {
        external_ipv4_address {
          address = yandex_vpc_address.bastion_address.external_ipv4_address[0].address
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.tf_router.id
      }
    }
  }
}




