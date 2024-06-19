{
  pkgs,
  config,
  inputs,
  ...
}: 
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    age.sshKeyPaths = [
      "/persist/etc/ssh/ssh_host_ed25519_key"
    ];
  };
  environment.systemPackages = [
    pkgs.sops
    pkgs.age
  ];
}