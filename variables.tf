################################################################################
# General
################################################################################

variable "name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# VPC
################################################################################

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "secondary_cidr_blocks" {
  description = "Additional CIDR blocks to associate with the VPC"
  type        = list(string)
  default     = []
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "Tenancy of instances launched into the VPC"
  type        = string
  default     = "default"
}

################################################################################
# Subnets
################################################################################

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ)"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (one per AZ)"
  type        = list(string)
  default     = []
}

variable "database_subnet_cidrs" {
  description = "CIDR blocks for database subnets (one per AZ)"
  type        = list(string)
  default     = []
}

variable "public_subnet_tags" {
  description = "Additional tags for public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for private subnets"
  type        = map(string)
  default     = {}
}

variable "database_subnet_tags" {
  description = "Additional tags for database subnets"
  type        = map(string)
  default     = {}
}

################################################################################
# NAT Gateway
################################################################################

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway for all AZs (cost saving for non-prod)"
  type        = bool
  default     = false
}

################################################################################
# VPC Endpoints
################################################################################

variable "enable_s3_endpoint" {
  description = "Enable S3 Gateway VPC endpoint"
  type        = bool
  default     = true
}

variable "enable_dynamodb_endpoint" {
  description = "Enable DynamoDB Gateway VPC endpoint"
  type        = bool
  default     = false
}

variable "interface_endpoints" {
  description = "List of AWS services for Interface VPC endpoints (e.g., ec2, ecr.api, ecr.dkr, sts, logs)"
  type        = list(string)
  default     = []
}

################################################################################
# Flow Logs
################################################################################

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = true
}

variable "flow_log_retention_days" {
  description = "CloudWatch log group retention in days for VPC flow logs"
  type        = number
  default     = 30
}
