variable "github_base_url" {
  description = "GITHUB_BASE_URL"
  default     = "https://api.github.com"
}

variable "github_token" {
  description = "GITHUB_TOKEN"
}

variable "github_organization" {
  description = "GitHub Organization"
}

data "external" "repositories" {
  program = [
    "${path.module}/list-organization-repositories.sh",
  ]

  query {
    base_url     = "${var.github_base_url}"
    organization = "${var.github_organization}"
    token        = "${var.github_token}"
  }
}

output "result" {
  value = "${data.external.repositories.result}"
}
