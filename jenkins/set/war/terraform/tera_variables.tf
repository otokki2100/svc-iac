variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "myip" {
  description = "My IP"
}

variable "wiki_code_path_local" {
  description = "Wiki Code Path Local"
}

variable "wiki_code_path_remote" {
  description = "Wiki Code Path Remote"
}

variable "ec2" {
  type = object({
    instance_type = string
    ami           = string
    user          = string
    dist          = string
    domain        = string
  })

  default = {
    instance_type = "t3.medium"
    ami           = "ami-022e1a32d3f742bd8"
    user          = "ec2-user"
    dist          = "amazl-23"
    domain        = "amazl-23"
  }
}

variable "domain" {
  description = "Domain"
}

locals {
  current_date = formatdate("YYMMDDHHmm", timestamp())
  domain = "jenkins-${local.current_date}.${var.domain}"
}
