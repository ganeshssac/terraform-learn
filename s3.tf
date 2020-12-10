resource "aws_s3_bucket" "b" {
  bucket = "mybucket-ganesh2020"
  acl    = "private"

  tags = {
    Name = "mybucket-ganesh2020"
  }
}
