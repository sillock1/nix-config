{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./lutris.nix
    ./prism-launcher.nix
    ./r2modman.nix
    ./steam.nix
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