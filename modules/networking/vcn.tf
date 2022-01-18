data "oci_identity_availability_domain" "AD" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

resource "oci_core_virtual_network" "this" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.tenancy_ocid
  display_name   = "${var.display_name}-vcn-${var.environment}"

  freeform_tags = merge(var.default_tags, {Environment: var.environment})
}

# VCN configuration
resource "oci_core_internet_gateway" "this" {
  compartment_id = var.tenancy_ocid
  display_name   = "${var.display_name}-igw-${var.environment}"
  vcn_id         = oci_core_virtual_network.this.id

  freeform_tags = merge(var.default_tags, {Environment: var.environment})
}

resource "oci_core_route_table" "this" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_virtual_network.this.id
  display_name   = "${var.display_name}-RouteTable-${var.environment}"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.this.id
  }

  freeform_tags = merge(var.default_tags, {Environment: var.environment})
}

resource "oci_core_security_list" "this" {
  compartment_id = var.tenancy_ocid
  display_name   = "${var.display_name}-SecurityList-${var.environment}"
  vcn_id         = oci_core_virtual_network.this.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "all"
    source   = var.vcn_cidr
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol = "1"
    source   = "0.0.0.0/0"

    icmp_options {
      type = 3
      code = 4
    }
  }

   freeform_tags = merge(var.default_tags, {Environment: var.environment})
}

module "subnet" {
  source = "../subnet"

  for_each = var.subnet_name

  availability_domain = data.oci_identity_availability_domain.AD.name
  cidr_block          = "${each.value.cidr_block}"
  display_name        = "${each.value.display_name}"
  compartment_id      = var.tenancy_ocid
  vcn_id              = oci_core_virtual_network.this.id
  route_table_id      = oci_core_route_table.this.id
  security_list_ids   = ["${oci_core_security_list.this.id}"]
  dhcp_options_id     = oci_core_virtual_network.this.default_dhcp_options_id

  freeform_tags = merge(var.default_tags, {Environment: var.environment})
}


