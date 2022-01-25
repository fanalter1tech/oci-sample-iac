variable "tenancy_ocid" {
  type = string
  default = "ocid1.tenancy.oc1..aaaaaaaahnckqhwjfwqqbv5lxxcvj74ydps2tok4mboblfenzo7ocvdrtcgq"
} 

variable "default_tags" {
  description = "tags to attach to all resources"
  default = {
    Tool        = "terraform"
    User        = "Tobi.Ogebule"
  }
}