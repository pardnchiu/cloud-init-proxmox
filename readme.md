# Import Cloud-init RedHat 9 / Debian 12 / Ubuntu 23 to Proxmox

- Proxmox 8.1.3
- storage ZFS
- RedHat 9.3
  ```sh
  qm.sh -i 999 -s storage -p rhel-9.3-x86_64-kvm.qcow2;
  ```
- Debian 12
  ```sh
  wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2;
  qm.sh -i 998 -s storage -p debian-12-generic-amd64.qcow2;
  ```
- Ubuntu 23.04
  ```sh
  wget https://cloud-images.ubuntu.com/lunar/current/lunar-server-cloudimg-amd64.img;
  qm.sh -i 997 -s storage -p lunar-server-cloudimg-amd64.img;
  ```

```sh
-i, --id [VMID]
-s, --storage [Storage ID]
-p, --path [Image Path]
-n, --name [VM Name | default qemu]
-c, --cpu [vCPU Number | default 2]
-r, --ram [RAM | default 2048]
```
