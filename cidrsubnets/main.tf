# -----------------------------
# Terraform setting
# -----------------------------
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# -----------------------------
# Provider setting
# -----------------------------
# AWS for Tokyo
provider "aws" {
  region = "ap-northeast-1"
}