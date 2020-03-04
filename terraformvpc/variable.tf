
 variable "ecs_cluster" {
   description = "ECS cluster name"
   default = "cmtest"
 }

 variable "ecs_key_pair_name" {
   description = "EC2 instance key pair name"
   default ="cmtestkey"
 }

variable "image_id" {
  default = " "
}

 variable "region" {
   description = "AWS region"
    default = "eu-west-1"
 }

variable "availability_zones" {
  description = "availability zone used for the demo, based on region"
  type = "list"
  default = ["eu-west-1a","eu-west-1b"]
}

variable "subnet_cidrs_public" {
  default = ["200.0.10.0/24", "200.0.20.0/24"]
  type = "list"
}

# variable "max_instance_size" {

# }

# variable "min_instance_size" {

# }

# variable "desired_capacity" {

# }