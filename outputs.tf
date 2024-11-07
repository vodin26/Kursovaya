output "bastion_external_ip" {
  value = yandex_vpc_address.bastion_address.external_ipv4_address.0.address
}
output "vm_names" {
  value = {
    for vm in [yandex_compute_instance.vm-a, yandex_compute_instance.vm-b] : vm.name => vm.network_interface.0.nat_ip_address...
  }
}

