resource "oci_core_virtual_network" "DevVCN" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.tenancy_ocid
  display_name   = "DevVCN"

  freeform_tags = merge(var.default_tags, {})
}

# VCN configuration
resource "oci_core_internet_gateway" "DevIG" {
  compartment_id = var.tenancy_ocid
  display_name   = "DevIG"
  vcn_id         = oci_core_virtual_network.DevVCN.id

  freeform_tags = merge(var.default_tags, {})
}

resource "oci_core_route_table" "DevRouteTable" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_virtual_network.DevVCN.id
  display_name   = "DevRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.DevIG.id
  }

  freeform_tags = merge(var.default_tags, {})
}

resource "oci_core_security_list" "DevSecurityList" {
  compartment_id = var.tenancy_ocid
  display_name   = "DevSecurityList"
  vcn_id         = oci_core_virtual_network.DevVCN.id

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

  freeform_tags = merge(var.default_tags, {})
}

resource "oci_core_subnet" "WebSubnet" {
  availability_domain = data.oci_identity_availability_domain.AD.name
  cidr_block          = var.web_subnet_cidr
  display_name        = "WebSubnet"
  compartment_id      = var.tenancy_ocid
  vcn_id              = oci_core_virtual_network.DevVCN.id
  route_table_id      = oci_core_route_table.DevRouteTable.id
  security_list_ids   = ["${oci_core_security_list.DevSecurityList.id}"]
  dhcp_options_id     = oci_core_virtual_network.DevVCN.default_dhcp_options_id

  freeform_tags = merge(var.default_tags, {})
}

resource "oci_core_subnet" "AppSubnet" {
  availability_domain = data.oci_identity_availability_domain.AD.name
  cidr_block          = var.app_subnet_cidr
  display_name        = "AppSubnet"
  compartment_id      = var.tenancy_ocid
  vcn_id              = oci_core_virtual_network.DevVCN.id
  route_table_id      = oci_core_route_table.DevRouteTable.id
  security_list_ids   = ["${oci_core_security_list.DevSecurityList.id}"]
  dhcp_options_id     = oci_core_virtual_network.DevVCN.default_dhcp_options_id

  freeform_tags = merge(var.default_tags, {})
}

resource "oci_core_subnet" "DBSubnet" {
  availability_domain = data.oci_identity_availability_domain.AD.name
  cidr_block          = var.db_subnet_cidr
  display_name        = "DBSubnet"
  compartment_id      = var.tenancy_ocid
  vcn_id              = oci_core_virtual_network.DevVCN.id
  route_table_id      = oci_core_route_table.DevRouteTable.id
  security_list_ids   = ["${oci_core_security_list.DevSecurityList.id}"]
  dhcp_options_id     = oci_core_virtual_network.DevVCN.default_dhcp_options_id

  freeform_tags = merge(var.default_tags, {})
}
