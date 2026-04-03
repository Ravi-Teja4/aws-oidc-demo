# ---------------------------
# IAM Role for EC2
# ---------------------------
resource "aws_iam_role" "ec2_s3_full_access_role" {
  name = "ec2-s3-full-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# ---------------------------
# Attach S3 Full Access Policy
# ---------------------------
resource "aws_iam_role_policy_attachment" "s3_full_access_attach" {
  role       = aws_iam_role.ec2_s3_full_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# ---------------------------
# Instance Profile (Required for EC2)
# ---------------------------
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-s3-full-access-profile"
  role = aws_iam_role.ec2_s3_full_access_role.name
}
