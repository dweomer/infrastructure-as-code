### VARIABLES #########################################################

variable "username" {
  description = "GitHub Username"
}

### DATA SOURCES ######################################################

data "github_user" "example" {
  username = "${var.username}"
}

### RESOURCES #########################################################

### OUTPUTS ###########################################################

output "login" {
  value = "${data.github_user.example.login}"
}

output "avatar_url" {
  value = "${data.github_user.example.avatar_url}"
}

output "gravatar_id" {
  value = "${data.github_user.example.gravatar_id}"
}

output "site_admin" {
  value = "${data.github_user.example.site_admin}"
}

output "name" {
  value = "${data.github_user.example.name}"
}

output "company" {
  value = "${data.github_user.example.company}"
}

output "blog" {
  value = "${data.github_user.example.blog}"
}

output "location" {
  value = "${data.github_user.example.location}"
}

output "email" {
  value = "${data.github_user.example.email}"
}

output "gpg_keys" {
  value = ["${data.github_user.example.gpg_keys}"]
}

output "ssh_keys" {
  value = ["${data.github_user.example.ssh_keys}"]
}

output "bio" {
  value = "${data.github_user.example.bio}"
}

output "public_repos" {
  value = "${data.github_user.example.public_repos}"
}

output "public_gists" {
  value = "${data.github_user.example.public_gists}"
}

output "followers" {
  value = "${data.github_user.example.followers}"
}

output "following" {
  value = "${data.github_user.example.following}"
}

output "created_at" {
  value = "${data.github_user.example.created_at}"
}

output "updated_at" {
  value = "${data.github_user.example.updated_at}"
}
