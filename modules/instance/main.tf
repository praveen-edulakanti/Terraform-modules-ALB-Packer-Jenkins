resource "aws_instance" "PublicInstance" {
	count = length(var.PublicInstances)
	 ami = lookup(var.PublicInstances[count.index], "ami")
	 availability_zone = lookup(var.PublicInstances[count.index], "availability_zone")
	 instance_type = lookup(var.PublicInstances[count.index], "instance_type")
	 key_name = lookup(var.PublicInstances[count.index], "key_name")
	 subnet_id = var.public_subnetID[count.index]
	 associate_public_ip_address = lookup(var.PublicInstances[count.index], "associate_public_ip_address")
	 user_data = file(lookup(var.PublicInstances[count.index], "user_data"))
	 vpc_security_group_ids = [var.PublicSecurityGrpID]
	 
	tags = {
		Name = lookup(var.PublicInstances[count.index], "name")
		Environment = var.environment
        Project = var.project
	    Terraformed = "True"
	}
}

resource "aws_instance" "PrivateInstance" {
	count = length(var.PrivateInstances)
	 ami = data.aws_ami.latest-ubuntu.id
	 availability_zone = lookup(var.PrivateInstances[count.index], "availability_zone")
	 instance_type = lookup(var.PrivateInstances[count.index], "instance_type")
	 key_name = lookup(var.PrivateInstances[count.index], "key_name")
	 subnet_id = var.private_subnetID[count.index]
	 associate_public_ip_address = lookup(var.PrivateInstances[count.index], "associate_public_ip_address")
	 vpc_security_group_ids = [var.PrivateSecurityGrpID]
	 
	tags = {
		Name = lookup(var.PrivateInstances[count.index], "name")
		Environment = var.environment
        Project = var.project
	    Terraformed = "True"
	}
}

data "aws_ami" "latest-ubuntu" {
 most_recent = true
 owners = ["863896359115"] # Canonical

  filter {
      name   = "name"
      values = ["Packer_UbuntuApachePhp *"]
  }

  filter {
      name   = "virtualization-type"
      values = ["hvm"]
  }
}