#!/bin/sh

VMID=""
NAME="qemu"
CPU="2"
RAM="2048"
STORAGE=""
IMAGE=""

OPTIONS=$(getopt -o i:s:p:ncr -l id:,storage:,path:,name,cpu,ram -- "$@")

if [ $? != 0 ] ; then echo "參數解析錯誤..." >&2 ; exit 1 ; fi

eval set -- "$OPTIONS"

while true; do
  case "$1" in
    -i | --id )
      VMID="$2"; shift 2 ;;
    -s | --storage )
      STORAGE="$2"; shift 2 ;;
    -p | --path )
      IMAGE="$2"; shift 2 ;;
    -n | --name )
      NAME="$2"; shift 2 ;;
    -c | --cpu )
      CPU="$2"; shift 2 ;;
    -r | --ram )
      RAM="$2"; shift 2 ;;
    -h | --help )
      HELP="true"; shift ;;
    -- )
      shift; break ;;
    * )
      break ;;
  esac
done

if [ "$HELP" = "true" ]; then
  echo "-i, --id [VMID]"
  echo "-s, --storage [Storage ID]"
  echo "-p, --path [Image Path]"
  echo "-n, --name [VM Name | default qemu]"
  echo "-c, --cpu [vCPU Number | default 2]"
  echo "-r, --ram [RAM | default 2048]"
  exit 0
fi

if [ "$VMID" = "" ] || [ "$STORAGE" = "" ] || [ "$PATH" = "" ]; then
  echo "-i, --id [VMID]"
  echo "-s, --storage [Storage ID]"
  echo "-p, --path [Image Path]"
  echo "-n, --name [VM Name | default qemu]"
  echo "-c, --cpu [vCPU Number | default 2]"
  echo "-r, --ram [RAM | default 2048]"
  exit 0
fi

/usr/sbin/qm create $VMID \
--name $NAME \
--cores $CPU \
--cpu x86-64-v2-AES \
--scsihw virtio-scsi-pci \
--memory $RAM \
--net0 virtio,bridge=vmbr0;

/usr/sbin/qm importdisk $VMID \
$IMAGE \
$STORAGE;

/usr/sbin/qm set $VMID \
--scsi0 storage:vm-$VMID-disk-0;

/usr/sbin/qm set $VMID \
--ide2 $STORAGE:cloudinit;

/usr/sbin/qm set $VMID \
--boot c --bootdisk scsi0;

/usr/sbin/qm set $VMID \
--ipconfig0 ip=dhcp;
