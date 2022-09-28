resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}

resource "aws_iam_user" "s3" {
  name = "sds-midterm-s3"
}

resource "aws_iam_access_key" "s3" {
  user = aws_iam_user.s3.name
}

resource "aws_iam_user_policy" "s3" {
  name = "SDSMidtermS3Access"
  user = aws_iam_user.s3.name

  policy = data.aws_iam_policy_document.s3.json
}

data "aws_iam_policy_document" "s3" {
  statement {
    actions   = ["s3:*"]
    resources = [aws_s3_bucket.bucket.arn, "${aws_s3_bucket.bucket.arn}/*"]
    effect    = "Allow"
  }
}

output "iam_s3_access_key" {
  value = aws_iam_access_key.s3.id
}

output "iam_s3_secret_key" {
  value = aws_iam_access_key.s3.secret
}
