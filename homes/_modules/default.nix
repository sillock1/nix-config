{
  pkgs,
  ...
}:
{
  imports = [
    ./programs
    ./desktops
  ];

  config = {
    home.stateVersion = "24.05";

    programs = {
      home-manager.enable = true;
    };

    xdg.enable = true;

    home.packages = [
      pkgs.home-manager
    ];
  };
}