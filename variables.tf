variable "cloud_id" {
  type = string
}
variable "folder_id" {
  type = string
}
variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}
variable "service_account_key_file" {
  type = string
}
variable "vpc_name" {
  type    = string
  default = "develop"
}
variable "vms_ssh_public_root_key" {
  type = string
}
variable "each_vm" {
  type = list(object({
    vm_name      = string
    cpu          = number
    ram          = number
    disk_volume  = number
  }))
  default = [
    { vm_name = "main", cpu = 2, ram = 2, disk_volume = 10 },
    { vm_name = "replica", cpu = 2, ram = 2, disk_volume = 10 }
  ]
}

variable "test_vpc" {
  type = object({
    network_id   = string
    subnet_ids   = list(string)
    subnet_zones = list(string)
  })
  default = {
    network_id = "enp7i560tb28nageq0cc"
    subnet_ids = ["e9b0le401619ngf4h68n", "e2lbar6u8b2ftd7f5hia", "b0ca48coorjjq93u36pl", "fl8ner8rjsio6rcpcf0h"]
    subnet_zones = ["ru-central1-a", "ru-central1-b", "ru-central1-c", "ru-central1-d"]
  }
}
