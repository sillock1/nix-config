{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./steam.nix
    ./prism-launcher.nix
  ];

  home = {
    packages = with pkgs; [
      gamescope
      lutris
      wineWowPackages.stable
    ];
    persistence = {
      "/persist/home/${config.home.username}" = {
        allowOther = true;
        directories = [
          "games"
        ];
      };
    };
  };
}