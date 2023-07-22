variable "myips" {
  type = string
  description = "My IPs"
}

locals {
  myips_list = split(",", var.myips)
}
