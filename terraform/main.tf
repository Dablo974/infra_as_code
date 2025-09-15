provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_credentials_validation = true
  endpoints {
    ec2 = "http://ip10-0-11-4-d33s7d9ntdlhbpdsdbeg-4566.direct.lab-boris.fr/"
  }
}

# Génère un suffixe aléatoire à chaque "terraform apply"
resource "random_id" "ami_suffix" {
  byte_length = 2
}

resource "aws_instance" "demo" {
  ami           = "ami-${random_id.ami_suffix.hex}"
  instance_type = "t2.micro"
}
