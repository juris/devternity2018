# provider "aws" {
#   region     = "eu-central-1"
#   access_key = "AWS_ACCESS_KEY"
#   secret_key = "AWS_SECRET_KEY"
# }

provider "aws" {
  region                  = "eu-central-1"
  shared_credentials_file = "/Users/juris/.aws/credentials"
  profile                 = "dt"
}

locals {
  common_tags = {
    project = "dt2018"
    env     = "prod"
  }
}

resource "aws_key_pair" "default_ssh_key" {
  key_name   = "default_ssh_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSHSyzyIDsc18RFCT62qIMstdby04BVA6iD7c7Q0437nPsauX/jz0BqG1avhIR27p3sYTa+qou6k0gV3+p8+KVgFHrrKH+20hOYD7QlB6mNtuQlaViga02Z2eiU1blEYoP/NMqx2eff7UunIKE4k9NaR2RUSBa9oErZigBxe7cIgyYY/bBoY4hDuly8ix/tmSPMPUsaW9UhWzUZab0YxdxiJZPwBfHQ+4GmpmrWx4L23JgnKEE04ODIkeGE8xu2G5ZBfpkaOD4/pZ5Lg57DsAIdT0cBAsOjPrvD60r+zyTeOEes9R+GUCj2AYMEBvg7yumsP7w/Let3uGAbEgZIFxx3azGikRxMG6VZVdzC1QH1tbzWyngpTrp6fG2FnpoG8s8yGuCViCGh4wrPHPQoWRFw45gG89TWp5C90FNB1z68c7cPRqqgCIh+LalhcmJ02MZROe0EMOZkUhM7lZOjp1yO3htbERmyvIuYZcoinCGLLpgT2uxwz5+vB6ywSSjw4TwydTFOpEyxLiC5qfMiRX9MNfcLdJZUMhcR45uC7qjdRLWZ6KsqtffxDcHhzgUvu3w+VkSjV1HktIrfgmcg/3o4Da77jBuv9SBRxlqmUsAgHIQ3F3DsUpovRJMZRW3G692IIXslWqPT2z4i8G9Ik8X6xKn9wyZC/v0SAH1oHMHDw== juris@zee.lv"
}

resource "aws_security_group" "thumbor_sg" {
  name        = "thumbor_sg"
  description = "Allow inbound traffic for Thumbor service"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(
    local.common_tags,
    map(
      "Name", "thumbor_sg"
    )
  )}"
}

resource "aws_default_vpc" "default_vpc" {
}

resource "aws_default_subnet" "default_az1a" {
  availability_zone = "eu-central-1a"
}

resource "aws_default_subnet" "default_az1b" {
  availability_zone = "eu-central-1b"
}