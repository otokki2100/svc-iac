module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"

  key_name           = "rsa-keypair-${timestamp()}"
  create_private_key = true
}

resource "local_file" "key_pair_private" {
  filename        = "./id_rsa"
  file_permission = "0600"
  content         = module.key_pair.private_key_pem
}
