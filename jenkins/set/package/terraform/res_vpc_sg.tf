module "service" {
  source  = "terraform-aws-modules/security-group/aws"

  name   = "service"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port       = -1
      to_port         = -1
      protocol        = "icmp"
      cidr_blocks = "${var.myip}/32"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "${var.myip}/32"
    },
    {
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = "${var.myip}/32"
    },    
    {
      from_port   = 2222
      to_port     = 2222
      protocol    = "tcp"
      cidr_blocks = "${var.myip}/32"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = "${var.myip}/32"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
