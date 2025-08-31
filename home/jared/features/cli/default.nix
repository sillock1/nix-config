{ pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./direnv.nix
    ./fish.nix
    ./fonts.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./ssh.nix
  ];
  home.packages = with pkgs; [
    bc # Calculator
    bottom # System viewer
    ncdu # TUI disk usage
    jq # JSON pretty printer and manipulator
    htop

    nixd # Nix LSP
    alejandra # Nix formatter
    nixfmt-rfc-style
    nvd # Differ
    nix-diff # Differ, more detailed
    nix-output-monitor
    nh # Nice wrapper for NixOS and HM

    uv

    ltex-ls # Spell checking LSP

    xclip

    envsubst
    ssh-to-age
    smartmontools # smartctl
    hdparm # Drive info

    nmap

    btop-rocm
  ];
}
