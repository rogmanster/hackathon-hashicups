provider "aws" {
  region  = var.region
}

module "frontend" {
  source = "./modules/instance"

  name              = "frontend"
  tags              = { Owner = "rchao@hashicorp.com", Region = "NA-WEST-STRAT", TTL = "3" , Purpose = "Demo"}
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  instance_type     = "t2.micro"
  public_key        = aws_key_pair.awskey.key_name
  private_ip        = "10.140.101.10"
  upstream_ip       = "10.140.101.11"

}

module "public_api" {
  source = "./modules/instance"

  name              = "public_api"
  tags              = { Owner = "rchao@hashicorp.com", Region = "NA-WEST-STRAT", TTL = "3" , Purpose = "Demo"}
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  instance_type     = "t2.micro"
  public_key        = aws_key_pair.awskey.key_name
  private_ip        = "10.140.101.11"
  upstream_ip       = "10.140.101.12"

}

module "product_api" {
  source = "./modules/instance"

  name              = "product_api"
  tags              = { Owner = "rchao@hashicorp.com", Region = "NA-WEST-STRAT", TTL = "3" , Purpose = "Demo"}
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  instance_type     = "t2.micro"
  public_key        = aws_key_pair.awskey.key_name
  private_ip        = "10.140.101.12"
  upstream_ip       = "10.140.101.13"

}

module "postgres" {
  source = "./modules/instance"

  name              = "postgres"
  tags              = { Owner = "rchao@hashicorp.com", Region = "NA-WEST-STRAT", TTL = "3" , Purpose = "Demo"}
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  instance_type     = "t2.micro"
  public_key        = aws_key_pair.awskey.key_name
  private_ip        = "10.140.101.13"
  upstream_ip       = "10.140.101.14"
}


module "network" {
  source = "./modules/network"

  name            = "rchao"
  private_subnets = ["10.140.1.0/24", "10.140.2.0/24", "10.140.3.0/24"]
  public_subnets  = ["10.140.101.0/24", "10.140.102.0/24", "10.140.103.0/24"]
  cidr_block      = "10.140.0.0/16"
}

/*
# Clean-up on destroy
resource "null_resource" "destroy" {
  provisioner "local-exec" {
    when    = destroy
    command = <<EOF
    rm awskey.pem
    rm bootstrap-*
EOF
  }
}*/
