provider "aws" { 
    region = "eu-west-3"
}

terraform {
    backend "s3" {
        bucket = "nazim-huseynov-terraform-state"
        key = "dev/network/terraform.tfstate"
        region = "eu-west-3"
    }
}
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "env" {
    default = "dev"
}

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.env}-vpc"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "${var.env}-igw"
    }
}

output "vpc_id" {
    value = aws_vpc.main.id
}

output "vpc_cidr" {
    value = aws_vpc.main.cidr_block
}