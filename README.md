<!-- BEGIN_TF_DOCS -->
# venky-terraform-module-vpc

Terraform module for provisioning a production-ready, multi-AZ AWS VPC.

## Features

> Secure-by-default, EKS-ready VPC module

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

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0, < 7.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0, < 7.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_cloudwatch_log_group.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_flow_log.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.vpc_endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.interface](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_ipv4_cidr_block_association.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones to use | `list(string)` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name prefix for all resources | `string` | n/a | yes |
| <a name="input_database_subnet_cidrs"></a> [database\_subnet\_cidrs](#input\_database\_subnet\_cidrs) | CIDR blocks for database subnets (one per AZ) | `list(string)` | `[]` | no |
| <a name="input_database_subnet_tags"></a> [database\_subnet\_tags](#input\_database\_subnet\_tags) | Additional tags for database subnets | `map(string)` | `{}` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable DNS hostnames in the VPC | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support in the VPC | `bool` | `true` | no |
| <a name="input_enable_dynamodb_endpoint"></a> [enable\_dynamodb\_endpoint](#input\_enable\_dynamodb\_endpoint) | Enable DynamoDB Gateway VPC endpoint | `bool` | `false` | no |
| <a name="input_enable_flow_logs"></a> [enable\_flow\_logs](#input\_enable\_flow\_logs) | Enable VPC Flow Logs | `bool` | `true` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Enable NAT Gateway for private subnets | `bool` | `true` | no |
| <a name="input_enable_s3_endpoint"></a> [enable\_s3\_endpoint](#input\_enable\_s3\_endpoint) | Enable S3 Gateway VPC endpoint | `bool` | `true` | no |
| <a name="input_flow_log_kms_key_arn"></a> [flow\_log\_kms\_key\_arn](#input\_flow\_log\_kms\_key\_arn) | ARN of KMS key for encrypting VPC Flow Logs CloudWatch log group | `string` | `null` | no |
| <a name="input_flow_log_retention_days"></a> [flow\_log\_retention\_days](#input\_flow\_log\_retention\_days) | CloudWatch log group retention in days for VPC flow logs | `number` | `365` | no |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | Tenancy of instances launched into the VPC | `string` | `"default"` | no |
| <a name="input_interface_endpoints"></a> [interface\_endpoints](#input\_interface\_endpoints) | List of AWS services for Interface VPC endpoints (e.g., ec2, ecr.api, ecr.dkr, sts, logs) | `list(string)` | `[]` | no |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | CIDR blocks for private subnets (one per AZ) | `list(string)` | `[]` | no |
| <a name="input_private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | Additional tags for private subnets | `map(string)` | `{}` | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | CIDR blocks for public subnets (one per AZ) | `list(string)` | `[]` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | Additional tags for public subnets | `map(string)` | `{}` | no |
| <a name="input_secondary_cidr_blocks"></a> [secondary\_cidr\_blocks](#input\_secondary\_cidr\_blocks) | Additional CIDR blocks to associate with the VPC | `list(string)` | `[]` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Use a single NAT Gateway for all AZs (cost saving for non-prod) | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_database_subnet_cidrs"></a> [database\_subnet\_cidrs](#output\_database\_subnet\_cidrs) | List of database subnet CIDR blocks |
| <a name="output_database_subnet_group_name"></a> [database\_subnet\_group\_name](#output\_database\_subnet\_group\_name) | Name of the database subnet group |
| <a name="output_database_subnet_ids"></a> [database\_subnet\_ids](#output\_database\_subnet\_ids) | List of database subnet IDs |
| <a name="output_flow_log_cloudwatch_log_group_arn"></a> [flow\_log\_cloudwatch\_log\_group\_arn](#output\_flow\_log\_cloudwatch\_log\_group\_arn) | ARN of the CloudWatch Log Group for VPC Flow Logs |
| <a name="output_flow_log_id"></a> [flow\_log\_id](#output\_flow\_log\_id) | ID of the VPC Flow Log |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | ID of the Internet Gateway |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | List of NAT Gateway IDs |
| <a name="output_nat_gateway_public_ips"></a> [nat\_gateway\_public\_ips](#output\_nat\_gateway\_public\_ips) | List of NAT Gateway public IPs |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | List of private route table IDs |
| <a name="output_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#output\_private\_subnet\_cidrs) | List of private subnet CIDR blocks |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | List of private subnet IDs |
| <a name="output_public_route_table_id"></a> [public\_route\_table\_id](#output\_public\_route\_table\_id) | ID of the public route table |
| <a name="output_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#output\_public\_subnet\_cidrs) | List of public subnet CIDR blocks |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | List of public subnet IDs |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | The ARN of the VPC |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_endpoint_dynamodb_id"></a> [vpc\_endpoint\_dynamodb\_id](#output\_vpc\_endpoint\_dynamodb\_id) | ID of the DynamoDB VPC endpoint |
| <a name="output_vpc_endpoint_interface_ids"></a> [vpc\_endpoint\_interface\_ids](#output\_vpc\_endpoint\_interface\_ids) | Map of Interface VPC endpoint IDs |
| <a name="output_vpc_endpoint_s3_id"></a> [vpc\_endpoint\_s3\_id](#output\_vpc\_endpoint\_s3\_id) | ID of the S3 VPC endpoint |
| <a name="output_vpc_endpoints_security_group_id"></a> [vpc\_endpoints\_security\_group\_id](#output\_vpc\_endpoints\_security\_group\_id) | ID of the VPC endpoints security group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->