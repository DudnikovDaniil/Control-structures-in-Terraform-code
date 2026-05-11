resource "yandex_compute_disk" "extra" {
  count = 3
  name  = "extra-disk-${count.index + 1}"
  type  = var.disk_type
  size  = var.disk_size
  zone  = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = var.storage_cores
    memory        = var.storage_memory
    core_fraction = var.storage_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.extra[*].id
    content {
      disk_id = secondary_disk.value
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.basic.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  }

  scheduling_policy {
    preemptible = true
  }
}
