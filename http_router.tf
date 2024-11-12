resource "yandex_alb_http_router" "tf_router" {
  name = "tf-router"
}

resource "yandex_alb_virtual_host" "virtual_host" {
  name           = "virt-host"
  http_router_id = yandex_alb_http_router.tf_router.id
  route {
    name = "my-route"
    http_route {
      http_match {
        path {
          prefix = "/"
        }
      }
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend-group.id
        timeout          = "10s"
      }
    }
  }
}

