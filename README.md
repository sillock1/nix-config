# nix-config
Configuration for my Nix based machines


# Install new machine


Boot into the live CD and run the following commands

Switch to root user and cleanup temporary nix install files

`sudo su && rm -rf /etc/nixos /etc/NIXOS && mkdir -p /etc/nixos`

Clone this repo into /etc/nixos 

`nix --experimental-features "nix-command flakes" run nixpkgs#git -- clone https://github.com/sillock1/nix-config.git /etc/nixos/.`

Use the disko utility for declarative disk configuration

`nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /etc/nixos/hosts/<machineName>/disko-config.nix`

Generate host ssh keys for SOPS encryption

`ssh-keygen -q -N "" -t ed25519 -f /mnt/persist/etc/ssh/ssh_host_ed25519_key`

`ssh-keygen -q -N "" -t rsa -b 4096 -f /mnt/persist/etc/ssh/ssh_host_rsa_key`

Output the age key

`nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'`

`nix-shell --experimental-features "nix-command flakes" -p git`

`nixos-install --flake .#<machineName>`

# Live ISO modify

cryptsetup open /dev/vda2 luks  --type luks
mount /dev/mapper/luks /mnt
mount /dev/vda1 /mnt/boot
