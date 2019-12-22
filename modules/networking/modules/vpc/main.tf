resource "aws_vpc" "vpc" {
       cidr_block  =  var.vpc.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
    enable_dns_support = true

  tags = {
         Name = var.vpc.name
	Environment = var.environment
	    Project = var.project
	Terraformed = "True"
  } 
}

resource "aws_internet_gateway" "internet_gateway_id" {
  vpc_id = aws_vpc.vpc.id

  tags = {
         Name = var.igw_name
	Environment = var.environment
      Project = var.project
	Terraformed = "True"
  }
}
