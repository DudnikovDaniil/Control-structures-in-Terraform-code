locals {
  vpc = {
    network_id   = yandex_vpc_network.develop.id
    subnet_ids   = yandex_vpc_subnet.develop[*].id
    subnet_zones = yandex_vpc_subnet.develop[*].zone
  }
}
