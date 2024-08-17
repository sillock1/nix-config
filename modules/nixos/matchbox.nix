{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.services.matchbox;
in
{
  options.modules.services.matchbox = {
    enable = lib.mkEnableOption "matchbox";
    apiVersion = lib.mkOption {
      type = lib.types.str;
      # renovate: depName=quay.io/poseidon/matchbox datasource=docker
      default = "v0.11.0@sha256:06bcdae85335fd00e8277b007b55cfb49d96a0114628c0f70db2b92b079d246a";
    };
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/matchbox";
    };
  };

  config = lib.mkIf cfg.enable {
    system.activationScripts.makeMatchboxDataDirs = lib.stringAfter [ "var" ] ''
        mkdir -p "/etc/matchbox"
        mkdir -p "${cfg.dataDir}/{assets},{groups},{profiles}"
        chown -R 999:999 ${cfg.dataDir}
      '';
    virtualisation.oci-containers.containers = {
      matchbox = {
        image = "quay.io/poseidon/matchbox:${cfg.apiVersion}";
        autoStart = true;
        ports = [ 
          "8080:8080"
          "8081:8081"
        ];
        volumes = [
          "/etc/matchbox:/etc/matchbox:Z,ro"
          "${cfg.dataDir}:/var/lib/matchbox:Z"
        ];
        cmd = [
          "-address=0.0.0.0:8080"
          "-rpc-address=0.0.0.0:8081"
          "-log-level=debug"
        ];
      };
    };
  };
}