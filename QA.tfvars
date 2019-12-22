region      = "ap-south-1"
environment = "QA"
project     = "DemoProject"
vpc = {
  name       = "QA_VPC"
  cidr_block = "10.100.0.0/16"
}
#Internet Gateway
igw_name = "QA-IGW"

#Elastic IP Address
EIPs = [
  {
    name = "QA-EIP1a"
  },
  {
    name = "QA-EIP1b"
  }
]

#NAT Gateway
NATGateways = [
  {
    name = "QA-NATGateway1a"
  },
  {
    name = "QA-NATGateway1b"
  }
]

public_subnets = [
  {
    name              = "QA-PublicSubnet1a"
    cidr_block        = "10.100.1.0/24"
    availability_zone = "ap-south-1a"
    #map_public_ip_on_launch = true
  },
  {
    name              = "QA-PublicSubnet1b"
    cidr_block        = "10.100.2.0/24"
    availability_zone = "ap-south-1b"
    #map_public_ip_on_launch = true
  }
]

private_subnets = [
  {
    name                    = "QA-PrivateSubnet1a"
    cidr_block              = "10.100.3.0/24"
    availability_zone       = "ap-south-1a"
    map_public_ip_on_launch = false
  },
  {
    name                    = "QA-PrivateSubnet1b"
    cidr_block              = "10.100.4.0/24"
    availability_zone       = "ap-south-1b"
    map_public_ip_on_launch = false
  }
]

private_subnet_route_tables = [
  {
    name = "QA-PrivateSubnetRT1"
  },
  {
    name = "QA-PrivateSubnetRT2"
  }
]

public_subnet_route_tables = [
  {
    name = "QA-PublicRT"
  }
]

PublicSecurityGrp_egress = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

PrivateSecurityGrp_egress = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]


PublicInstances = [
  {
    name                        = "QA-PublicInstance1a"
    ami                         = "ami-0123b531fc646552f" #Ubuntu Server 18.04 LTS (HVM)
    availability_zone           = "ap-south-1a"
    instance_type               = "t2.micro"
    key_name                    = "terraform-demo"
    associate_public_ip_address = true
    user_data                   = "./user-data/user-data-pub1.sh"
  },
  {
    name                        = "QA-DBServer"
    ami                         = "ami-0123b531fc646552f" #Ubuntu Server 18.04 LTS (HVM)
    availability_zone           = "ap-south-1b"
    instance_type               = "t2.micro"
    key_name                    = "terraform-demo"
    associate_public_ip_address = true
    user_data                   = "./user-data/user-data-mysql.sh"
  }
]

PrivateInstances = [
  {
    name                        = "QA-PrivateInstance1a"
    ami_name                    = "Packer_UbuntuApachePhp"
    availability_zone           = "ap-south-1a"
    instance_type               = "t2.micro"
    key_name                    = "terraform-demo"
    associate_public_ip_address = false
   
  },
  {
    name                        = "QA-PrivateInstance1b"
    ami_name                    = "Packer_UbuntuApachePhp"
    availability_zone           = "ap-south-1b"
    instance_type               = "t2.micro"
    key_name                    = "terraform-demo"
    associate_public_ip_address = false
  }
]

LoadBalancerName = "QA-LoadBalancer"

TargetGroupNames = [
  {
    name = "QA-User-Service"
  },
  {
    name = "QA-Dashboard-Service"
  }
]

AlbForwardRules = [
	{
		  name = "QA-user"
		  priority  = 90
		  type = "forward"
		  field = "path-pattern"
		  values = "/user*"
	},
	{
		  name = "QA-dashboard"
		  priority  = 100
		  type = "forward"
		  field = "path-pattern"
		  values = "/dashboard*"
	}
]

Route53zone_id   = "Z24SDMK7FWJ00J"

DomainAliases = [
  {
    DomainName = "qa.edulakanti.info"
  }
]