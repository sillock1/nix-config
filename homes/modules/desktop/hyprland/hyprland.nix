{ inputs, pkgs, config, lib, ...}: 
{
    systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland = {
        enable = true;
        # hidpi = true;
      };
      # enableNvidiaPatches = false;
      systemd.enable = true;
      extraConfig = builtins.readFile ./conf/hyprland.conf;
    };
    xdg.configFile = {
      "hypr/mako" = {
        source = ./conf/mako;
        recursive = true;
      };
      "hypr/scripts" = {
        source = ./conf/scripts;
        recursive = true;
        executable = true;
      };
      "hypr/waybar" = {
        source = ./conf/waybar;
        recursive = true;
      };
      "hypr/wlogout" = {
        source = ./conf/wlogout;
        recursive = true;
      };
    };
}