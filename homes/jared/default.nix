{
  hostname,
  ...
}:
{
  imports = [
    ./sops.nix
    ./hosts/${hostname}.nix
  ];
}