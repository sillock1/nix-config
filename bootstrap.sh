#!/bin/sh

nix-shell --experimental-features "nix-command flakes" -p git
nixos-install --flake .#$1