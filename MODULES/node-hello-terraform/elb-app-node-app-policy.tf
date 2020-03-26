resource "aws_s3_bucket_policy" "node-app" {
  bucket = "${aws_s3_bucket.node-app-elb-bucket.id}"

  policy = <<POLICY

{
        "Version": "2012-10-17",
        "Id": "AWSConsole-AccessLogs-Policy-1472578198092",
        "Statement": [
                {
                        "Sid": "AWSConsoleStmt-1472578198092",
                        "Effect": "Allow",
                        "Principal": {
                                "AWS": "arn:aws:iam::127311923021:root"
                        },
                        "Action": "s3:PutObject",
                        "Resource": "arn:aws:s3:::elb-access-log.node-app-us-east-1/AWSLogs/499869180143/*"
                }
        ]
}

POLICY
}
