# Объявление переменных для конфиденциальных параметров
variable "token_id" {
  type = string
}
variable "cloud_id" {
  type = string
}
variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key" {
  type      = string
  sensitive = true
}