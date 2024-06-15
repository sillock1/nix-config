{
  config,
  ...
}:
''
include "${config.sops.secrets."networking/bind/rndc-key".path}";
include "${config.sops.secrets."networking/bind/externaldns-key".path}";

controls {
  inet 127.0.0.1 allow {localhost;} keys {"rndc-key";};
};

# Only define the known VLAN subnets as trusted
acl "trusted" {
  10.1.0.0/24;    # LAN
  10.1.7.0/24;    # SERVERS
  10.5.0.0/24;    # CONTAINERS
};

options {
  directory "${config.services.bind.directory}";
  pid-file "${config.services.bind.directory}/named.pid";
  listen-on { 127.0.0.1; 10.5.0.3; };

  allow-recursion {
    trusted;
  };
  allow-transfer {
    none;
  };
  allow-update {
    none;
  };
};

logging {
  channel stdout {
    stderr;
    severity info;
    print-category yes;
    print-severity yes;
    print-time yes;
  };
  category security { stdout; };
  category dnssec   { stdout; };
  category default  { stdout; };
};

zone "pill.ac." {
  type master;
  file "${config.sops.secrets."networking/bind/zones/pill.ac".path}";
  journal "${config.services.bind.directory}/db.pill.ac.jnl";
  update-policy {
    grant ddnsupdate zonesub ANY;
    grant * self * A;
  };
};

zone "sillock.io." {
  type master;
  file "${config.sops.secrets."networking/bind/zones/sillock.io".path}";
  journal "${config.services.bind.directory}/db.sillock.io.jnl";
  allow-transfer {
    key "externaldns";
  };
  update-policy {
    grant externaldns zonesub ANY;
    grant ddnsupdate zonesub ANY;
    grant * self * A;
  };
};

zone "1.10.in-addr.arpa." {
  type master;
  file "${config.sops.secrets."networking/bind/zones/1.10.in-addr.arpa".path}";
  journal "${config.services.bind.directory}/db.1.10.in-addr.arpa.jnl";
  update-policy {
    grant ddnsupdate zonesub ANY;
    grant * self * A;
  };
};
''