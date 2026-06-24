################################################################################
# VPC
################################################################################

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.this.arn
}

################################################################################
# Subnets
################################################################################

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "List of database subnet IDs"
  value       = aws_subnet.database[*].id
}

output "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  value       = aws_subnet.public[*].cidr_block
}

output "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  value       = aws_subnet.private[*].cidr_block
}

output "database_subnet_cidrs" {
  description = "List of database subnet CIDR blocks"
  value       = aws_subnet.database[*].cidr_block
}

output "database_subnet_group_name" {
  description = "Name of the database subnet group"
  value       = try(aws_db_subnet_group.this[0].name, null)
}

################################################################################
# Route Tables
################################################################################

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = try(aws_route_table.public[0].id, null)
}

output "private_route_table_ids" {
  description = "List of private route table IDs"
  value       = aws_route_table.private[*].id
}

################################################################################
# NAT Gateway
################################################################################

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.this[*].id
}

output "nat_gateway_public_ips" {
  description = "List of NAT Gateway public IPs"
  value       = aws_eip.nat[*].public_ip
}

################################################################################
# Internet Gateway
################################################################################

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = try(aws_internet_gateway.this[0].id, null)
}

################################################################################
# VPC Endpoints
################################################################################

output "vpc_endpoint_s3_id" {
  description = "ID of the S3 VPC endpoint"
  value       = try(aws_vpc_endpoint.s3[0].id, null)
}

output "vpc_endpoint_dynamodb_id" {
  description = "ID of the DynamoDB VPC endpoint"
  value       = try(aws_vpc_endpoint.dynamodb[0].id, null)
}

output "vpc_endpoint_interface_ids" {
  description = "Map of Interface VPC endpoint IDs"
  value       = { for k, v in aws_vpc_endpoint.interface : k => v.id }
}

################################################################################
# Security Groups
################################################################################

output "vpc_endpoints_security_group_id" {
  description = "ID of the VPC endpoints security group"
  value       = try(aws_security_group.vpc_endpoints[0].id, null)
}

################################################################################
# Flow Logs
################################################################################

output "flow_log_id" {
  description = "ID of the VPC Flow Log"
  value       = try(aws_flow_log.this[0].id, null)
}

output "flow_log_cloudwatch_log_group_arn" {
  description = "ARN of the CloudWatch Log Group for VPC Flow Logs"
  value       = try(aws_cloudwatch_log_group.flow_log[0].arn, null)
}
