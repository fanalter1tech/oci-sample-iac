variable "tenancy_ocid" {
  type = string
  default = "ocid1.tenancy.oc1..aaaaaaaahnckqhwjfwqqbv5lxxcvj74ydps2tok4mboblfenzo7ocvdrtcgq"
} 

variable "user_ocid" {
  type = string
  default = "ocid1.user.oc1..aaaaaaaaiwasp2rrmk2ragekndrgkdh7blrkc7q7vtidrl7qf2ollwzohijq"
} 

variable "fingerprint" {
  type = string 
  default = "d7:e1:b3:62:f8:4f:c5:d3:7f:d8:d3:fe:7b:a9:ad:fa"
} 

variable "private_key_path" {
  type = string   
  default ="~/.oci/oci_rsa.pem"
} 

variable "region" {
  type = string         
  default = "us-ashburn-1"
} 
        
variable "environment" {
  type        = string
  description = "environment name"
  default = "dev"
}

variable "default_tags" {
  description = "tags to attach to all resources"
  default = {
    Tool        = "terraform"
    User        = "Tobi.Ogebule"
  }
}

variable "subnet_name" {
  description = "Map of subnet names"
  type        = map
  default     = {
    WebSubnet = {
        display_name   = "WebSubnet"
        cidr_block     = "10.0.0.0/24" 
    },
    AppSubnet = {
        display_name   = "AppSubnet"
        cidr_block     = "10.0.1.0/24"
    },
    DBSubnet = {
        display_name   = "DBSubnet"
        cidr_block     = "10.0.2.0/24"
    }
  }
}


