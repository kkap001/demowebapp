module "vpc" {
  source          = "./../../modules/tf-aws-vpc"
  vpc_cidr       = "10.0.0.0/16"
  vpc_name       = "dev-vpc"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  azs            = ["us-east-1a", "us-east-1b"]
}

module "iam" {
  source                = "./../../modules/tf-aws-iam"  
}

module "demo-ec2" {
  source                = "./../../modules/tf-aws-ec2"
  env                   = "dev"
  project               = "demo"
  key_name              = "dev"
  vpc_id                =  module.vpc.vpc_id  # Dynamically use VPC output
  subnet_id             = element(module.vpc.public_subnets, 0)
  length                = "1"
  instance_type         = "t3.micro"
  ami                   = "ami-0e001c9271cf7f3b9"
  volume_size           = "15"
  volume_type           = "gp3"
  encrypted             = true
  delete_on_termination = false
  eip                   = true
  load_balancer         = false
  ssh_ports             = [22]
  ssh_cidr_block        = ["0.0.0.0/0"]
  web_ports             = [8081, 443]
  web_cidr_blocks       = ["0.0.0.0/0"]
  iam_role              = module.iam.iam_instance_profile_name
}