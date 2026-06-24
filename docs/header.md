# venky-terraform-module-vpc

Terraform module for provisioning a production-ready, multi-AZ AWS VPC.

## Features

- Multi-AZ public, private, and database subnets
- NAT Gateway (single or per-AZ for HA)
- Internet Gateway
- VPC Gateway endpoints (S3, DynamoDB)
- VPC Interface endpoints (configurable)
- VPC Flow Logs to CloudWatch
- Secondary CIDR block support
- EKS-ready subnet tagging

## Usage

```hcl
module "vpc" {
  source = "git::https://github.com/venky1912/venky-terraform-module-vpc.git?ref=v0.1.0"

  name               = "platform-dev"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true # Set false for prod HA

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  interface_endpoints = ["ec2", "ecr.api", "ecr.dkr", "sts"]

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
```
