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

# cidr_block
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

# natgateway
variable "public_natgateway_count" {
  default = 1
}

# azs
variable "azs" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

# Subnet CIDR
# public_sunets

variable "public_sunets" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

# private_sunets
variable "private_sunets" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}