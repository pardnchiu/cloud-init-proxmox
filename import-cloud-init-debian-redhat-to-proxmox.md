# Import Cloud-init Debian 12 / RedHat 9 to Proxmox

### Debian Image

```sh
wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2;
```

### Create a VM

```sh
qm create [VMID] \
--name [NAME] \
--cores [vCPU] \
--cpu x86-64-v2-AES \
--scsihw virtio-scsi-pci \
--memory [RAM] \
--net0 virtio,bridge=vmbr0;
```

### Import Image

```sh
qm importdisk [VMID] \
[Image Path] \
[Storage ID];
```

### Mount Disk

```sh
qm set [VMID] \
--scsi0 storage:vm-[VMID]-disk-0;
```

### Add Cloud-init

```sh
qm set [VMID] \
--ide2 [Storage ID]:cloudinit;
```

### Boot from Disk

```sh
qm set [VMID] \
--boot c --bootdisk scsi0;
```

### IP

```sh
qm set [VMID] --ipconfig0 ip=dhcp;
#qm set [VMID] --ipconfig0 ip=10.8.9.2/24,gw=10.8.9.1
```

### Sample

```sh
qm create 999 \
--name redhat \
--cores 2 \
--cpu x86-64-v2-AES \
--scsihw virtio-scsi-pci \
--memory 2048 \
--net0 virtio,bridge=vmbr0 \
--agent 1;

qm importdisk 999 \
/root/rhel-9.3-x86_64-kvm.qcow2 \
storage;

qm set 999 \
--scsi0 storage:vm-999-disk-0;

qm set 999 \
--ide2 storage:cloudinit;

qm set 999 \
--boot c --bootdisk scsi0;

qm set 999 \
--ipconfig0 ip=dhcp;
```
