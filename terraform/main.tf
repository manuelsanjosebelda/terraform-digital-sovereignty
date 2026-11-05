resource "aws_instance" "web_server" {
    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [
        aws_security_group.web_sg.id
    ]

    metadata_options {
      http_tokens = "required"
    }

    root_block_device {
      encrypted = true
    }
    tags = {
      Name = "sovereignty-web-server"
      Environment = var.envirorament
    }
}