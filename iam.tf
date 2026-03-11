resource "aws_iam_user" "dev_user" {
  name = "terraform-user-2"

  tags = {
    Description = "IAM user created with Terraform"
    Environment = "Dev"
  }
}

resource "aws_iam_user_policy_attachment" "admin_policy" {
  user       = aws_iam_user.dev_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "dev_user_key" {
  user = aws_iam_user.dev_user.name
}
