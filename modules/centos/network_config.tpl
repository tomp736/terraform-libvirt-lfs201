version: 2
ethernets:
  eth0:
    addresses: [192.168.11.${addr}/24]
    gateway4: 192.168.11.1
    nameservers:
      addresses:
      - 192.168.11.1
      - 8.8.8.8
      - 8.8.4.4
      search: [ labrats.work.inflancka ]