resource "null_resource" "local_exec" {
  provisioner "local-exec" {
    command = "hostname"
  }
}
