resource "aws_key_pair" "rsa_keypair_exist" {
  key_name   = "rsa_keypair"
  public_key = file("~/.ssh/id_rsa.pub")
  tags = {
    Name = "rsa-keypair-exist"
  }
}
