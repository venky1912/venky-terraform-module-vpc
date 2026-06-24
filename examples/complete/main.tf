module "vpc" {
  source = "../../"

  name               = "platform-dev"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs  = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  database_subnet_cidrs = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_s3_endpoint       = true
  enable_dynamodb_endpoint = true
  interface_endpoints      = ["ec2", "ecr.api", "ecr.dkr", "sts", "logs"]

  enable_flow_logs        = true
  flow_log_retention_days = 14

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  tags = {
    Environment = "dev"
    Project     = "eks-platform"
    ManagedBy   = "terraform"
  }
}
