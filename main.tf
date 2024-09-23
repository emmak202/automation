module "vpc" {
  source = "./modules/network"  

}

module "k8-cluster" {
  source = "./modules/k8s"
  vpc_id = module.vpc.vpc-id
  vpc_cidr = var.vpc_cidr
  public_subnet_id = module.vpc.public1_id
  
  
}