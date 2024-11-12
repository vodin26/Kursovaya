resource "yandex_alb_target_group" "target-group" {
  name = "target-group"

  target {
    subnet_id  = yandex_compute_instance.vm-a.network_interface.0.subnet_id
    ip_address = yandex_compute_instance.vm-a.network_interface.0.ip_address
  }
  target {
    subnet_id  = yandex_compute_instance.vm-b.network_interface.0.subnet_id
    ip_address = yandex_compute_instance.vm-b.network_interface.0.ip_address
  }
}