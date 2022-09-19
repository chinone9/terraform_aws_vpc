# -----------------------------
# Identifier
# -----------------------------
# Name header
locals {
  name_header = "example"
}
# Environment
locals {
  env = "dev"
}

locals {
  resource_name_tpl = "${local.name_header}-${local.env}"
}

# -----------------------------
# VPC
# -----------------------------
# VPC name
locals {
  vpc_name = "${local.resource_name_tpl}-vpc"
}

# IGW name
locals {
  igw_name = "${local.resource_name_tpl}-igw"
}

# RouteTable name
locals {
  public_rtb_name = "${local.resource_name_tpl}-public-rtb"
}
locals {
  private_rtb_name = "${local.resource_name_tpl}-private-rtb"
}
locals {
  database_rtb_name = "${local.resource_name_tpl}-database-rtb"
}

# cidr_block
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

# natgateway
variable "public_natgateway_count" {
  default = 1
}

# Subnet CIDR
# variableで設定されたCIDRからサブネットCIDR×9を自動生成する
locals {
  cidr            = var.vpc_cidr_block
  cidr_subnets    = [for cidr_block in cidrsubnets(local.cidr, 4, 4, 4) : cidrsubnets(cidr_block, 4, 4, 4)]
  public_subnets  = local.cidr_subnets[0]
  private_subnets = local.cidr_subnets[1]
  database_subnets = local.cidr_subnets[2]
}