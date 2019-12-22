output "Environment" {
  value = var.environment
}

output "Region" {
  value = var.region
}

output "Project" {
  value = var.project
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "vpcName" {
  value = var.vpc.name
}

output "vpcCIDR" {
  value = var.vpc.cidr_block
}

output "InternetGateway" {
  value = var.igw_name
}

output "internet_gateway_id" {
  value = module.networking.internet_gateway_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
}

output "PublicSecurityGrpID" {
  value = module.security.public_securityGrp
}

output "PrivateSecurityGrpID" {
  value = module.security.private_securityGrp
}

output "LoadBalSecurityGrpID" {
  value = module.security.loadbalancer_securityGrp
}

output "PrivateInstanceIds" {
    value = module.instance.PrivateInstanceIds
}

output "AppLoadBalancerURL" {
    value = module.apploadbalancer.route53_alias
}

output "Targetgroup_ids" {
    value = module.apploadbalancer.Targetgroup_ids
}