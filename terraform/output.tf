# Load Balancer
output "load_balancer_external_ip" {
  description = "Внешний IP балансировщика нагрузки"
  value       = yandex_alb_load_balancer.load-balancer.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

# Bastion
output "bastion_external_ip" {
  description = "Внешний IP бастионного хоста"
  value       = yandex_compute_instance.bastion.network_interface[0].nat_ip_address
}

output "bastion_internal_ip" {
  description = "Внутренний IP бастионного хоста"
  value       = yandex_compute_instance.bastion.network_interface[0].ip_address
}

# Web Servers
output "web1_internal_ip" {
  description = "Внутренний IP веб-сервера 1"
  value       = yandex_compute_instance.web1.network_interface[0].ip_address
}

output "web2_internal_ip" {
  description = "Внутренний IP веб-сервера 2"
  value       = yandex_compute_instance.web2.network_interface[0].ip_address
}

# Zabbix
output "zabbix_external_ip" {
  description = "Внешний IP Zabbix"
  value       = yandex_compute_instance.zabbix.network_interface[0].nat_ip_address
}

output "zabbix_internal_ip" {
  description = "Внутренний IP Zabbix"
  value       = yandex_compute_instance.zabbix.network_interface[0].ip_address
}

# ElasticSearch
output "elastic_internal_ip" {
  description = "Внутренний IP ElasticSearch"
  value       = yandex_compute_instance.elastic.network_interface[0].ip_address
}

# Kibana
output "kibana_external_ip" {
  description = "Внешний IP Kibana"
  value       = yandex_compute_instance.kibana.network_interface[0].nat_ip_address
}

output "kibana_internal_ip" {
  description = "Внутренний IP Kibana"
  value       = yandex_compute_instance.kibana.network_interface[0].ip_address
}