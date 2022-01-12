output "groups" {
  value = oci_identity_group.these
}

output "memberships" {
  value = local.group_memberships
}

output "ADs" {
    value = data.oci_identity_availability_domain.AD
}

