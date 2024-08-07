{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    fastfetch
    git
    dig
    lsof
  ];
}