{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    pulseaudio
  ];
  hardware.pulseaudio.enable = true;
}