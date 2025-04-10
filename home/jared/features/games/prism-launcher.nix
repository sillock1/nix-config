{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      unstable.prismlauncher
    ];

    persistence = {
      "/persist/home/${config.home.username}".directories = [".local/share/PrismLauncher"];
    };
  };
}
