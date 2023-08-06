module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"

  key_name           = "rsa-keypair-${timestamp()}"
  create_private_key = true
}

resource "local_file" "key_pair_public" {
  filename        = "./id_rsa.pub"
  file_permission = "0600"
  content         = module.key_pair.public_key_openssh
}

resource "local_file" "key_pair_private" {
  filename        = "./id_rsa"
  file_permission = "0600"
  content         = module.key_pair.private_key_pem
}
