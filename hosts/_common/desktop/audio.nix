{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    pulseaudio
  ];
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };
}