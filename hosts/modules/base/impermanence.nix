{...}:
{
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
}