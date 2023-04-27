#creation d'un datacenter - cluster ainsi que plusieurs vm
terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.3.1"
    }
  }
}


provider "vsphere" {
    user                 = "administrator@vsphere.local"
    password             = "admin123+M"
    vsphere_server       = "192.168.77.100"
    allow_unverified_ssl = true
}
