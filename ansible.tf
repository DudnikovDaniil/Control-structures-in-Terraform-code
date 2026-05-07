resource "local_file" "inventory" {
  content = templatefile("${path.module}/templates/hosts.tftpl", {
    webservers = yandex_compute_instance.web
    databases  = yandex_compute_instance.db
    storage    = [yandex_compute_instance.storage]
  })
  filename = "${abspath(path.module)}/inventory.ini"
}
