resource "aws_key_pair" "rsa_keypair" {
  key_name   = "rsa_keypair"
  public_key = file("id_rsa.pub")
  tags = {
    Name = "rsa_keypair"
  }
}
