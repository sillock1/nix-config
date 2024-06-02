{
  pkgs,
  lib,
  config,
  inputs,
  hostname,
  flake-packages,
  ...
}:
{
  imports = [
    ../modules

    #./secrets
    ./hosts/${hostname}.nix
  ];
}