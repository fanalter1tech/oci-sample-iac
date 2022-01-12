
# users are all users in the tenancy 
# groups are all identity groups in the tenancy
locals {
  groups = { for g in oci_identity_group.these : g.name => g }
  users  = { for u in data.oci_identity_users.these.users : u.name => u }

  group_memberships = flatten([
    for k, v in var.groups : [
      for user_id in v.user_ids : {
        group_name = k
        user_id    = user_id
      }
    ]
  ])
}

# Gets users in the OCI tenancy
data "oci_identity_users" "these" {
  compartment_id = var.tenancy_ocid
}

# Creates an identity group in the tenancy for each group
# This resource provides the Group resource in OCI Identity service
resource "oci_identity_group" "these" {
  for_each       = var.groups
  compartment_id = var.tenancy_ocid
  name           = each.key
  description    = each.value.description

  freeform_tags = merge(var.default_tags, {})
}

# creates the groups membership
resource "oci_identity_user_group_membership" "these" {
  for_each = { for m in local.group_memberships : "${m.group_name}.${m.user_id}" => m }
  group_id = local.groups[each.value.group_name].id
  user_id  = local.users[each.value.user_id].id
}
