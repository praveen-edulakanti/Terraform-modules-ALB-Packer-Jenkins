module "networking" {
  source                      = "./modules/networking"
  environment                 = var.environment
  project                     = var.project
  vpc                         = var.vpc
  igw_name                    = var.igw_name
  EIPs                        = var.EIPs
  NATGateways                 = var.NATGateways
  private_subnets             = var.private_subnets
  public_subnets              = var.public_subnets
  private_subnet_route_tables = var.private_subnet_route_tables
  public_subnet_route_tables  = var.public_subnet_route_tables

}

module "security" {
  source                    = "./modules/security"
  environment               = var.environment
  project                   = var.project
  vpc_id                    = module.networking.vpc_id
  PublicSecurityGrp_egress  = var.PublicSecurityGrp_egress
  PrivateSecurityGrp_egress = var.PrivateSecurityGrp_egress
}

module "instance" {
  source               = "./modules/instance"
  environment          = var.environment
  project              = var.project
  PublicInstances      = var.PublicInstances
  PrivateInstances     = var.PrivateInstances
  public_subnetID      = module.networking.public_subnet_ids
  private_subnetID     = module.networking.private_subnet_ids
  PublicSecurityGrpID  = module.security.public_securityGrp
  PrivateSecurityGrpID = module.security.private_securityGrp
}

module "apploadbalancer" {
  source               = "./modules/apploadbalancer"
  environment          = var.environment
  project              = var.project
  vpc_id               = module.networking.vpc_id
  public_subnetID      = module.networking.public_subnet_ids
  LoadBalSecurityGrpID = module.security.loadbalancer_securityGrp
  TargetGroupNames     = var.TargetGroupNames
  AlbForwardRules      = var.AlbForwardRules
  PrivateInstanceIds   = module.instance.PrivateInstanceIds
  LoadBalancerName     = var.LoadBalancerName
}

module "route53" {
  source           = "./modules/route53"
  Route53zone_id   = var.Route53zone_id
  alias            = module.apploadbalancer.route53_alias
  DomainAliases    = var.DomainAliases
}