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
    ../_modules

    #./secrets
    ./hosts/${hostname}.nix
  ];
}