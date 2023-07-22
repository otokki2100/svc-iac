resource "tls_private_key" "rsa_key_new" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "local_file" "rsa_key_new_private" {
  filename        = "./id_rsa"
  file_permission = "0600"
  content         = tls_private_key.rsa_key_new.private_key_pem
}

resource "aws_key_pair" "rsa_keypair_new" {
  key_name   = "rsa_keypair"
  public_key = tls_private_key.rsa_key_new.public_key_openssh
  tags = {
    Name = "rsa_keypair-new"
  }
}
