module "my_vpc" {
  source = "./modules/vpc"

  vpc_name          = "MyModuleVPC"
  cidr_block        = "10.1.0.0/16"
  subnet_cidr       = "10.1.1.0/24"
  availability_zone = "us-east-1a"
}

output "module_vpc_id" {
  value = module.my_vpc.vpc_id
}

output "module_subnet_id" {
  value = module.my_vpc.subnet_id
}

