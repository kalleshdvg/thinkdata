variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = "map"
  default = {
    ap-south-1 = "ami-0a574895390037a62"
    ap-southeast-1 = "ami-295d7b55"
    }
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "thinkdata"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "thinkdata.pub"
}