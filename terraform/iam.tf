resource "aws_iam_role" "altimonia_api_task_execution_role" {
  name               = "altimonia-api-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "ecs_task_execution_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Attach the above policy to the execution role.
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.altimonia_api_task_execution_role.name
  policy_arn = data.aws_iam_policy.ecs_task_execution_policy.arn
}

# Allow read access to ALL secrets in region
# TODO limit to specific secret
data "aws_iam_policy_document" "get_secret_policy_document" {
  statement {
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    resources = [
      "arn:aws:secretsmanager:${var.region}:${var.aws_account_id}:secret:*"
    ]
  }

  statement {
    actions   = ["secretsmanager:ListSecrets"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "get_secret_policy" {
  name   = "altimonia-api-get-secret-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.get_secret_policy_document.json
}

# Attach the above policy to the execution role.
resource "aws_iam_role_policy_attachment" "get_secret_policy" {
  role       = aws_iam_role.altimonia_api_task_execution_role.name
  policy_arn = aws_iam_policy.get_secret_policy.arn
}
