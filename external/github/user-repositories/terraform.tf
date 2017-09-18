variable "github_base_url" {
  description = "GITHUB_BASE_URL"
  default     = "https://api.github.com"
}

variable "github_token" {
  description = "GITHUB_TOKEN"
}

variable "github_username" {
  description = "GitHub Username"
}

data "external" "repositories" {
  program = [
    "${path.module}/list-user-repositories.sh"
  ]

  query {
    base_url = "${var.github_base_url}"
    username = "${var.github_username}"
    token    = "${var.github_token}"
  }
}

output "result" {
  value = "${data.external.repositories.result}"
}
