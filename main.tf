terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  service_account_key_file = "key.json" # yc iam key create --output key.json --service-account-name my-service-account
  cloud_id                 = "b1geeuij36lubph60chm"
  folder_id                = "b1g9a0ig1pg9lr4oc5ie"
  zone                     = "ru-central1-a"
}