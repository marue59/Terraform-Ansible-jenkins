data "vsphere_datacenter" "datacenter" {
  name = "datacenter"
}

data "vsphere_compute_cluster" "cluster" {
  name            = "terraform-cluster-ESXI"
  datacenter_id   = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore1" {
  datacenter_id = data.vsphere_datacenter.datacenter.id
  name          = "datastore1"
}

data "vsphere_datastore" "datastore2" {
  datacenter_id = data.vsphere_datacenter.datacenter.id
  name          = "datastore1 (1)"
}

data "vsphere_virtual_machine" "vm-template" {
  name          = "vm-template"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm-ansible" {
  name             = "vm-ansible"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore1.id
  num_cpus         = 2
  memory           = 1024
  
  guest_id         = data.vsphere_virtual_machine.vm-template.guest_id
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.vm-template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.vm-template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.vm-template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.vm-template.id
    customize {
      linux_options {
        host_name = "vm-ansible"
        domain    = "local"
      }
      network_interface {
        ipv4_address = "192.168.77.50"
        ipv4_netmask = 24
      }
    }
  }
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0
}

resource "vsphere_virtual_machine" "vm-jenkins" {
  name             = "vm-jenkins"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore1.id
  num_cpus         = 2
  memory           = 1024
  
  guest_id         = data.vsphere_virtual_machine.vm-template.guest_id
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.vm-template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.vm-template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.vm-template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.vm-template.id
    customize {
      linux_options {
        host_name = "vm-jenkins"
        domain    = "local"
      }
      network_interface {
        ipv4_address = "192.168.77.51"
        ipv4_netmask = 24
      }
    }
  }
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0
}

resource "vsphere_virtual_machine" "vm-deploy" {
  name             = "vm-deploy"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore1.id
  num_cpus         = 2
  memory           = 1024
  
  guest_id         = data.vsphere_virtual_machine.vm-template.guest_id
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.vm-template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.vm-template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.vm-template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.vm-template.id
    customize {
      linux_options {
        host_name = "vm-deploy"
        domain    = "local"
      }
      network_interface {
        ipv4_address = "192.168.77.52"
        ipv4_netmask = 24
      }
    }
  }
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0
}