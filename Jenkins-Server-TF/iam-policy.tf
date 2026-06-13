resource "aws_iam_role_policy_attachment" "iam-policy" {
  # Attach AWS managed AdministratorAccess to the instance role.
  # This is simple for a lab setup, but it is far broader than a production-safe policy.
  role = aws_iam_role.iam-role.name

  # Just for testing purpose, don't try to give administrator access
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
