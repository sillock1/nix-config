{
  bind = import ./bind.nix;
  blocky = import ./blocky.nix;
  dnsdist = import ./dnsdist.nix;
  dnsmasq = import ./dnsmasq.nix;
  haproxy = import ./haproxy.nix;
  matchbox = import ./matchbox.nix;
}