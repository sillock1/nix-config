{
  ...
}:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
        # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
        # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
    };
  };

  security.pam.sshAgentAuth.enable = true;
}