resource "aws_instance" "my_app_server" {
    count = 2
    ami = var.ami
    instance_type = var.instance_type
    tags = {
        Name = "${var.my_env}-tws-demo-app-server"
    }
}