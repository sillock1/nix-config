{
  pkgs,
  ...
}:
{
  imports = [
    
  ];

  home = {
    packages = with pkgs; [gamescope];
    persistence = {
      "/persist/${config.home.homeDirectory}" = {
        allowOther = true;
        directories = [
          "Games"
        ];
      };
    };
  };
}