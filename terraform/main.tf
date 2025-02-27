terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.84.0"
}

provider "yandex" {
  token     = var.token_id
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}