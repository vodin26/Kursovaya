resource "yandex_lb_target_group" "tr_gr" {
  name = "tr_gr"
  target {
    subnet_id = yandex_vpc_subnet.internal_subnet.id
    address = yandex_compute_instance.vm-a.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.internal_subnet.id
    address = yandex_compute_instance.vm-b.network_interface.0.ip_address
  }
}