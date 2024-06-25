{
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
}