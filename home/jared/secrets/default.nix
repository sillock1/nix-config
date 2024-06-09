{
  pkgs,
  config,
  ...
}: let
  ageKeyFile = "/home/jared/.config/age/keys.txt";
in {
  config = {
    sops = {
      age.keyFile = ageKeyFile;
      age.generateKey = true;
    };
    home.sessionVariables = {
      SOPS_AGE_KEY_FILE = ageKeyFile;
    };
  };
}