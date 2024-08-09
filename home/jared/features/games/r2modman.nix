{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    r2modman
  ];

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [
      ".config/r2modmanPlus-local"
    ];
  };
}