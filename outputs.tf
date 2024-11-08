output "bastion_external_ip" {
  value = yandex_vpc_address.bastion_address.external_ipv4_address.0.address
}
output "ip_address_a" {
  value = yandex_compute_instance.vm-a.network_interface[0].ip_address
}

output "ip_address_b" {
  value = yandex_compute_instance.vm-b.network_interface[0].ip_address
}

