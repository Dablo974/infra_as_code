variable "commit_hash" {
  description = "Hash du commit Git actuel"
  type        = string
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_credentials_validation = true
  endpoints {
    ec2 = "http://ip10-0-11-4-d33s7d9ntdlhbpdsdbeg-4566.direct.lab-boris.fr"
  }
}

locals {
  unique_ami = "ami-${substr(var.commit_hash, 0, 8)}"
}

resource "aws_instance" "demo" {
  ami           = local.unique_ami
  instance_type = "t2.micro"
  tags = {
    Name       = "Instance-GitCommit-${var.commit_hash}"
    CommitHash = var.commit_hash
  }
}

output "instance_id" {
  value = aws_instance.demo.id
}
