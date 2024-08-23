{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.services.dnsmasq;
in
{
  options.modules.services.dnsmasq = {
    enable = lib.mkEnableOption "dnsmasq";
    apiVersion = lib.mkOption {
      type = lib.types.str;
      # renovate: depName=quay.io/poseidon/dnsmasq datasource=docker
      default = "v0.5.0-31-gdc1adc8@sha256:6a839fde323fb405f6be84003a6b9019d9151caa983bfdcbc8cc1b51b1f8627d";
    };
    hostIP = lib.mkOption {
      type = lib.types.str;
    };
  };
  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      dnsmasq = {
        image = "quay.io/poseidon/dnsmasq:${cfg.apiVersion}";
        autoStart = true;
        extraOptions = [
          "--network=host"
          "--cap-add=NET_ADMIN"
          "--cap-add=NET_RAW"
          "--cap-add=NET_BIND_SERVICE"
        ];
        cmd = [
          "--log-dhcp"
          "--log-queries"
          "--no-daemon"
          "--port=0"
          "--dhcp-range=10.1.7.1,proxy,255.255.255.0"
          "--enable-tftp"
          "--tftp-root=/var/lib/tftpboot"
          "--pxe-service=tag:#ipxe,x86PC,\"PXE chainload to iPXE\",undionly.kpxe"
          "--dhcp-userclass=set:ipxe,iPXE"
          "--pxe-service=tag:ipxe,x86PC,\"iPXE\",http://matchbox.pill.ac:8080/boot.ipxe"
        ];
      };
    };
  };
}
