virsh shutdown --domain centos-0
virsh shutdown --domain ubuntu-0
virsh shutdown --domain fedora-0

virsh undefine --domain centos-0
virsh undefine --domain ubuntu-0
virsh undefine --domain fedora-0