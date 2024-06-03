{
  hostname,
  ...
}:
{
  imports = [
    ./hosts/${hostname}.nix
  ];
}