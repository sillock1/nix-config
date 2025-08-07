{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      prismlauncher
    ];

    persistence = {
      "/persist/home/${config.home.username}".directories = [".local/share/PrismLauncher"];
    };
  };
}
