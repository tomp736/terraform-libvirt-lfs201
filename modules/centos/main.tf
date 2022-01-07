data "template_file" "network_setting" {
  template = file("${path.module}/network_config.tpl")
  count    = var.centos_count
  vars = {
    addr = 30 + count.index
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
  count    = var.centos_count
  vars = {
    fqdn = "centos-${count.index}.labrats.work.inflancka" 
  }
}

resource "libvirt_volume" "volume_centos" {
  count          = var.centos_count
  name           = "centos-${count.index}"
  pool           = "kvm-pool"
  base_volume_id = libvirt_volume.base_centos.id
  format         = "qcow2"
  size           = var.centos_disk_size
}

resource "libvirt_cloudinit_disk" "centosinit" {
  count          = var.centos_count
  name           = "centosinit-${count.index}"
  pool           = "kvm-pool"
  user_data      = element(data.template_file.user_data.*.rendered, count.index)
  network_config = element(data.template_file.network_setting.*.rendered, count.index)
}

resource "libvirt_domain" "centos" {
  count     = var.centos_count
  name      = "centos-${count.index}"
  memory    = var.centos_memory
  vcpu      = var.centos_cpus
  autostart = "true"

  network_interface {
    network_name = "bridged-network"
    addresses    = ["192.168.11.${30 + count.index}"]
  }

  disk {
    volume_id = element(libvirt_volume.volume_centos.*.id, count.index)
  }

  cloudinit = element(libvirt_cloudinit_disk.centosinit.*.id, count.index)

  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }
}