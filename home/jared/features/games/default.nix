{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./steam.nix
    ./prism-launcher.nix
    ./lutris.nix
  ];

  home = {
    packages = with pkgs; [
      gamescope
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