# main

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
variable "default_zone" {
  description = "The default zone"
  type        = string
  default     = "ru-central1-a"
}


#subnet
variable "subnets" {
  description = "Subnets for www cluster"

  type = map(list(object(
    {
      name = string,
      zone = string,
      cidr = list(string)
    }))
  )
}
