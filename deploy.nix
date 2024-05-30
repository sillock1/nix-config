{
  self,
  deploy-rs,
  ...
}:
let
  deployConfig = name: system: cfg: {
    hostname = "${name}.pill.ac";
    sshOpts = cfg.sshOpts or ["-A"];

    profiles = {
      system = {
        inherit (cfg) sshUser;
        path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.${name};
        user = "root";
      };
    };

    remoteBuild = cfg.remoteBuild or false;
    autoRollback = cfg.autoRollback or false;
    magicRollback = cfg.magicRollback or true;
  };
in
{
  deploy.nodes = {
    intelsat = deployConfig "intelsat" "x86_64-linux" {sshUser = "jared"; remoteBuild = true;};
  };
  checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
}