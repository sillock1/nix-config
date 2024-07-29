#!/bin/sh

if [ "$3" = "y" ]
  then
    cryptsetup open /dev/$2 luks  --type luks
    mount /dev/mapper/luks /mnt
    mount /dev/vda1 /mnt/boot
    cp /mnt/persist/etc/ssh/ssh_host_* /etc/nixos
fi

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /etc/nixos/hosts/$1/disko-config.nix

if [ "$3" = "y" ]
  then
    mkdir -p /mnt/persist/etc/ssh
    cp /etc/nixos/ssh_host_* /mnt/persist/etc/ssh
  else
    ssh-keygen -q -N "" -t ed25519 -f /mnt/persist/etc/ssh/ssh_host_ed25519_key
fi