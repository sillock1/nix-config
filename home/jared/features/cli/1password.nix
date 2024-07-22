{
  pkgs, 
  ... 
}:
{
   home.packages = with pkgs; [
    _1password
  ];

  persistence."/persist/home/${config.home.username}" = {
    defaultDirectoryMethod = "symlink";
    allowOther = true;
    directories = ["~/.config/1Password/"];
  }; 
}