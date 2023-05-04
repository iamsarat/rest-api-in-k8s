data "aws_region" "current" {}

data "aws_availability_zones" "availability_zones" {
  state = "available"
}
