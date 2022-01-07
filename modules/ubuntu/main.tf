data "template_file" "network_setting" {
  template = file("${path.module}/network_config.tpl")
  count    = var.ubuntu_count
  vars = {
    addr = 40 + count.index
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
  count    = var.ubuntu_count
  vars = {
    fqdn = "ubuntu-${count.index}.labrats.work.inflancka"
  }
}

resource "libvirt_volume" "volume_ubuntu" {
  count          = var.ubuntu_count
  name           = "ubuntu-${count.index}"
  pool           = "kvm-pool"
  base_volume_id = libvirt_volume.base_ubuntu.id
  format         = "qcow2"
  size           = var.ubuntu_disk_size
}

resource "libvirt_cloudinit_disk" "ubuntuinit" {
  count          = var.ubuntu_count
  name           = "ubuntuinit-${count.index}"
  pool           = "kvm-pool"
  user_data      = element(data.template_file.user_data.*.rendered, count.index)
  network_config = element(data.template_file.network_setting.*.rendered, count.index)
}

resource "libvirt_domain" "ubuntu" {
  count     = var.ubuntu_count
  name      = "ubuntu-${count.index}"
  memory    = var.ubuntu_memory
  vcpu      = var.ubuntu_cpus
  autostart = "true"

  network_interface {
    network_name = "bridged-network"
    addresses    = ["192.168.11.${40 + count.index}"]
  }

  disk {
    volume_id = element(libvirt_volume.volume_ubuntu.*.id, count.index)
  }

  cloudinit = element(libvirt_cloudinit_disk.ubuntuinit.*.id, count.index)

  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }
}