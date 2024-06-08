{
  pkgs,
  config,
  ...
}:
{
  config = {
    sops = {
      defaultSopsFile = ./secrets.sops.yaml;
      secrets = {
        "users/jared/password" = {
          neededForUsers = true;
        };
      };
    };
  };
}