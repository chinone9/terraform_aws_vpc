# -----------------------------
# General
# -----------------------------
# Current AWS Account ID
data "aws_caller_identity" "current" {}
# Current User ID with AWS Account
data "aws_canonical_user_id" "current" {}
# Current region
data "aws_region" "current" {}
# AZ
data "aws_availability_zones" "available" {}
