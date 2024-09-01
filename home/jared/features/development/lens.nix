{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    lens
  ];

    persistence = {
      "/persist/home/${config.home.username}" = {
        allowOther = true;
        directories = [
          ".config/Lens"
        ];
      };
    };
}
