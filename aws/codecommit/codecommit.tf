### VARIABLES #########################################################

variable "repository_name" {
  default     = "example-tf"
  description = "Repository Name"
}

variable "repository_description" {
  default     = "Example Repository (Terraform)"
  description = "Repository Description"
}

variable "repository_default_branch" {
  default     = "master"
  description = "Repository Default Branch"
}

### DATA SOURCES ######################################################

data "aws_caller_identity" "whoami" {
  # This lets us leverage the associated account_id in policy documents.
}

data "aws_iam_policy_document" "example_queue" {
  policy_id = "${aws_sqs_queue.example.arn}/SendMessage"

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "${aws_sqs_queue.example.arn}",
    ]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"

      values = [
        "${aws_sns_topic.example.arn}",
      ]
    }
  }
}

### RESOURCES #########################################################

resource "aws_sns_topic" "example" {
  name         = "codecommit-${var.repository_name}"
  display_name = "CodeCommit - ${var.repository_description}"
}

resource "aws_sqs_queue" "example" {
  name = "codecommit-${var.repository_name}"

  # See http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-subscribe-queue-sns-topic.html
  # "Amazon SNS isn't currently compatible with FIFO queues."
}

resource "aws_sqs_queue_policy" "example" {
  queue_url = "${aws_sqs_queue.example.id}"
  policy = "${data.aws_iam_policy_document.example_queue.json}"
}

resource "aws_sns_topic_subscription" "example" {
  topic_arn = "${aws_sns_topic.example.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.example.arn}"
}

resource "aws_codecommit_repository" "example" {
  default_branch  = "${var.repository_default_branch}"
  description     = "${var.repository_description}"
  repository_name = "${var.repository_name}"
}

resource "aws_codecommit_trigger" "example_all" {
  repository_name = "${aws_codecommit_repository.example.repository_name}"

  trigger {
    name = "ANY-BRANCH"

    events = [
      "all",
    ]

    destination_arn = "${aws_sns_topic.example.arn}"
  }
}

### OUTPUTS ###########################################################

output "repository_arn" {
  value = "${aws_codecommit_repository.example.arn}"
}

output "repository_url_http" {
  value = "${aws_codecommit_repository.example.clone_url_http}"
}

output "repository_url_ssh" {
  value = "${aws_codecommit_repository.example.clone_url_ssh}"
}

output "repository_topic_arn" {
  value = "${aws_sns_topic.example.arn}"
}

output "repository_topic_name" {
  value = "${aws_sns_topic.example.name}"
}

output "repository_queue_arn" {
  value = "${aws_sqs_queue.example.arn}"
}

output "repository_queue_name" {
  value = "${aws_sqs_queue.example.name}"
}
