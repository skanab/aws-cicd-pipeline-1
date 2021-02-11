data "aws_secretsmanager_secret_version" "pgpkey" {
  secret_id = "pgpkey"
}

locals {
  pgpkey = data.aws_secretsmanager_secret_version.pgpkey.secret_string
}

resource "aws_iam_user" "cloud-admins" {
  for_each = toset(var.cloud-admins)
  name = each.key
  force_destroy = true
  provisioner "local-exec" {
      command = "sleep 120"
  }
}

resource "aws_iam_user_login_profile" "cloud-admins-profiles" {
#  provisioner "local-exec" {
#      command = "sleep "
#  }
  for_each = toset(var.cloud-admins)
  user = each.key
  pgp_key = local.pgpkey
}

output "key" {
  value = local.pgpkey
}
output "password" {
  value = aws_iam_user_login_profile.cloud-admins-profiles[*]
}
