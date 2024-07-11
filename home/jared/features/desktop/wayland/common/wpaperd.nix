{
  config,
  ...
}:
{
  programs.wpaperd = {
    enable = true;
    settings = {
      any = {
        duration = "30m";
        mode = "center";
        sorting = "random";
        path = "~/Pictures/wallpapers";
      };
    };
  };

  home.persistence = {
    "/persist/${config.home.homeDirectory}".files = [".config/wpaperd/wallpaper.toml"];
  };
}