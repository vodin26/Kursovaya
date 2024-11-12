output "bastion_external_ip" {
  value = yandex_compute_instance.bastion-host.network_interface[0].nat_ip_address
}
output "ip_address_a" {
  value = yandex_compute_instance.vm-a.network_interface[0].ip_address
}

output "ip_address_b" {
  value = yandex_compute_instance.vm-b.network_interface[0].ip_address
}

output "load_balancer_ip" {
  value = yandex_alb_load_balancer.load_balancer.listener[0].endpoint[0].address[0].external_ipv4_address
}

output "zabbix_ip" {
  value = yandex_compute_instance.zabbix.network_interface[0].nat_ip_address
}

output "kibana_ip" {
  value = yandex_compute_instance.kibana.network_interface[0].nat_ip_address
}

output "elasticsearch_ip" {
  value = yandex_compute_instance.elasticsearch.network_interface[0].ip_address
}