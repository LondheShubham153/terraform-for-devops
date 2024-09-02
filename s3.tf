resource "aws_s3_bucket" "testbucket" {
    bucket = "${var.my_enviroment}-test-my-app-bucket-d"
}
