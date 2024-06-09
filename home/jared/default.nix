{
  hostname,
  ...
}:
{
  imports = [
    ./secrets
    ./hosts/${hostname}.nix
  ];
}