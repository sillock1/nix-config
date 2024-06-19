{ ... }:
{
  home.persistence."/home/jared" = {
    removePrefixDirectory = true;
    allowOther = true;
    directories = [
      "git"   
    ];
    files = [
    ];
  };
}