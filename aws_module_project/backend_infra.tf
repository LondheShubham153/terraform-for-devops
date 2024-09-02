# Backend Variables
variable "state_bucket_name" {
    default = "tws-demo-state-bucket"
}

variable "state_table_name" {
    default = "tws-demo-state-table"
}

variable "aws_region" {
    default = "us-east-2"
}


# backend resources
resource "aws_dynamodb_table" "my_state_table" {
    name = var.state_table_name
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        Name = var.state_table_name
    }
}

resource "aws_s3_bucket" "my_state_bucket" {
    bucket = var.state_bucket_name
    tags = {
        Name = var.state_bucket_name
    }
}