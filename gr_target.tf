resource "yandex_alb_target_group" "target_group" {
  name = "target-group"

  target {
    subnet_id  = yandex_compute_instance.vm_a.network_interface.0.subnet_id
    ip_address = yandex_compute_instance.vm_a.network_interface.0.ip_address
  }
  target {
    subnet_id  = yandex_compute_instance.vm_b.network_interface.0.subnet_id
    ip_address = yandex_compute_instance.vm_b.network_interface.0.ip_address
  }
}
