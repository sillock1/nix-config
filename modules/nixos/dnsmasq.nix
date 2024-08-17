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
          "--cap-add=NET_ADMIT"
        ];
        cmd = [
          "--log-dhcp" 
          "--log-queries" 
          "--no-daemon"
          "--port=0"
          "--dhcp-range=10.1.7.1,proxy,255.255.255.0"
          "--enable-tftp"
          "--tftp-root=/var/lib/tftpboot"
          "--pxe-service=net:#ipxe,x86PC,,undionly.kpxe"
          "--pxe-service=net:#ipxe,X86-64_EFI,,ipxe.efi"
          "--dhcp-match=set:bios,option:client-arch,0"
          "--dhcp-boot=tag:bios,undionly.kpxe"
          "--dhcp-match=set:efi32,option:client-arch,6"
          "--dhcp-boot=tag:efi32,ipxe.efi"
          "--dhcp-match=set:efibc,option:client-arch,7"
          "--dhcp-boot=tag:efibc,ipxe.efi"
          "--dhcp-match=set:efi64,option:client-arch,9"
          "--dhcp-boot=tag:efi64,ipxe.efi"
          "--dhcp-match=set:arm64,option:client-arch,11"
          "--dhcp-boot=tag:arm64,ipxe-arm64.efi"
          "--dhcp-userclass=set:ipxe,iPXE"
          "--dhcp-boot=tag:ipxe,http://${cfg.hostIP}/boot.ipxe"
        ];
      };
    };
  };
}