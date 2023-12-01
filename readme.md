# Import Cloud-init Debian 12 / RedHat 9 to Proxmox

```sh
wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2;
qm.sh -i 998 -s storage -p debian-12-generic-amd64.qcow2;
```

```sh
-i, --id [VMID]
-s, --storage [Storage ID]
-p, --path [Image Path]
-n, --name [VM Name | default qemu]
-c, --cpu [vCPU Number | default 2]
-r, --ram [RAM | default 2048]
```
