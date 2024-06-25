{pkgs, ...}: {
  fontProfiles = {
    enable = true;
    monospace = {
      family = "FiraCode Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "Iosevka"];};
    };
    regular = {
      family = "Fira Sans";
      package = pkgs.fira;
    };
  };
}