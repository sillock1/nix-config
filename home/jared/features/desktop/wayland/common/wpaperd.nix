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
     "/persist/home/${config.home.username}".files = [".config/wpaperd/wallpaper.toml"];
   };
}