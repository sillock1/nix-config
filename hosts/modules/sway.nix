{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    kitty
  ];
  security.polkit.enable = true;
}