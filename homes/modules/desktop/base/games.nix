{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    prismlauncher # MC Launcher
    pcsx2 # PS2 Emulator
    gamemode
  ];
}