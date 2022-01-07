resource "libvirt_volume" "base_centos" {
  name   = "base_centos"
  pool   = "kvm-pool"
  source = "/mnt/kvm/images/centos7-cloudimg-amd64.qcow2"
  format = "qcow2"
}