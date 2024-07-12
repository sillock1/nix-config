{
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [inputs.impermanence.nixosModules.impermanence];
  environment = {
    persistence = {
      "/persist" = {
        hideMounts = true;
        directories = [
          "/etc/secureboot"
          "/var/log" # persist logs between reboots for debugging
          "/var/lib/cache" # cache files (restic, nginx, containers)
          "/var/lib/nixos" # nixos state
        ];
        files = [
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
          "/etc/machine-id"
          "/etc/adjtime"
        ];
      };
    };
  };
programs.fuse.userAllowOther = true;
system.activationScripts.persistent-dirs.text = let
    mkHomePersist = user:
      lib.optionalString user.createHome ''
        mkdir -p /persist/${user.home}
        chown ${user.name}:${user.group} /persist/${user.home}
        chmod ${user.homeMode} /persist/${user.home}
      '';
    users = lib.attrValues config.users.users;
  in
    lib.concatLines (map mkHomePersist users);
}