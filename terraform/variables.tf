variable "aws_region"{
    description = "AWS region for infrastructure deployment"
    type = string
    default = "eu-west-1"
}

variable "envirorament"{
    description = "Deployment envirorament"
    type = string
    default = "development"
}

variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type = string

}
variable "instance_type"{
    description = "Approved EC2 instance type"
    type = string
    default = "t3.micro"
}
