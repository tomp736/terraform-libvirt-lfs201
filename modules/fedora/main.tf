data "template_file" "network_setting" {
  template = file("${path.module}/network_config.tpl")
  count    = var.fedora_count
  vars = {
    addr = 50 + count.index
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
  count    = var.fedora_count
  vars = {
    fqdn = "fedora-${count.index}.labrats.work.inflancka" 
  }
}

resource "libvirt_volume" "volume_fedora" {
  count          = var.fedora_count
  name           = "fedora-${count.index}"
  pool           = "kvm-pool"
  base_volume_id = libvirt_volume.base_fedora.id
  format         = "qcow2"
  size           = var.fedora_disk_size
}

resource "libvirt_cloudinit_disk" "fedorainit" {
  count          = var.fedora_count
  name           = "fedorainit-${count.index}"
  pool           = "kvm-pool"
  user_data      = element(data.template_file.user_data.*.rendered, count.index)
  network_config = element(data.template_file.network_setting.*.rendered, count.index)
}

resource "libvirt_domain" "fedora" {
  count     = var.fedora_count
  name      = "fedora-${count.index}"
  memory    = var.fedora_memory
  vcpu      = var.fedora_cpus
  autostart = "true"

  network_interface {
    network_name = "bridged-network"
    addresses    = ["192.168.11.${50 + count.index}"]
  }

  disk {
    volume_id = element(libvirt_volume.volume_fedora.*.id, count.index)
  }

  cloudinit = element(libvirt_cloudinit_disk.fedorainit.*.id, count.index)

  graphics {
    type        = "vnc"
    listen_type = "address"
    autoport    = true
  }
}