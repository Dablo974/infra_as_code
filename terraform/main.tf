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

# Génère un identifiant unique basé sur le hash du commit Git
locals {
  commit_hash = trimspace(file(".git/refs/heads/main")) # Remplace "main" par ta branche si nécessaire
  unique_ami   = "ami-${substr(local.commit_hash, 0, 8)}" # Utilise les 8 premiers caractères du hash
}

resource "aws_instance" "demo" {
  ami           = local.unique_ami
  instance_type = "t2.micro"
  tags = {
    Name        = "Instance-GitCommit-${local.commit_hash}"
    CommitHash  = local.commit_hash
  }
}

output "instance_id" {
  value = aws_instance.demo.id
}
