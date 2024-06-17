{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    dig
    lsof
  ];
}