resource "aws_iam_role" "admin_role" {
  name = "admin-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "admin_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.admin_role.name
}

resource "aws_iam_policy_attachment" "admin_attach" {
  name       = "admin-policy-attachment"
  roles      = [aws_iam_role.admin_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_policy_attachment" "admin_attach_secrets" {
  name       = "admin-policy-attachment-secrets"
  roles      = [aws_iam_role.admin_role.name]
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}