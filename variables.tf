variable "tenancy_ocid" {
  description = "The OCID of the tenancy."
  type        = string
  default = "ocid1.tenancy.oc1..aaaaaaaahnckqhwjfwqqbv5lxxcvj74ydps2tok4mboblfenzo7ocvdrtcgq"
}

variable "user_ocid" {
  description = "The user OCID"
  type        = string
  default = "ocid1.user.oc1..aaaaaaaaiwasp2rrmk2ragekndrgkdh7blrkc7q7vtidrl7qf2ollwzohijq"
}

variable "fingerprint" {
  description = ""
  type        = string
  default = "d7:e1:b3:62:f8:4f:c5:d3:7f:d8:d3:fe:7b:a9:ad:fa"
}

variable "private_key_path" {
  description = "Path to the rsa private key"
  type        = string
  default  = "~/.oci/oci_rsa.pem"
}

variable "region" {
  description = "The geographic area to place the resources"
  type        = string
  default     = "us-ashburn-1"
}

variable "groups" {
  description = "Group parameters"
  type = map(object({
    description  = string,
    user_ids     = list(string),
    defined_tags = map(string),
  }))

  default = {
    security-admin-group = {
      description  = "Landing Zone group for managing security services."
      user_ids     = []
      defined_tags = null
    },
    database-admin-group = {
      description  = "Landing Zone group for managing databases."
      user_ids     = []
      defined_tags = null
    },
    iam-admin-group = {
      description  = "Landing Zone group for managing IAM resources in the tenancy."
      user_ids     = []
      defined_tags = null
    },
    appdev-admin-group = {
      description  = "Landing Zone group for managing app development related services."
      user_ids     = []
      defined_tags = null
    },
    network-admin-group = {
      description  = "Landing Zone group for managing networking in compartment."
      user_ids     = []
      defined_tags = null
    },
    announcement-admin-group = {
      description  = "Landing Zone group for managing the console announcements."
      user_ids     = []
      defined_tags = null
    },
    cred-admin-group = {
      description  = "Landing Zone group for managing users credentials in the tenancy."
      user_ids     = []
      defined_tags = null
    },
    auditor-group =  {
      description  = "Landing Zone group for auditing the tenancy."
      user_ids     = []
      defined_tags = null
    }
  }
}
