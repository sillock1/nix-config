{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home = {
    persistence."/persist/home/${config.home.username}" = {
      allowOther = true;
      directories = [
        "Downloads"
        "Documents"
        "Pictures"
        "Videos"
        ".local/bin"
        ".local/share/nix" # trusted settings and repl history
      ];
    };
  };
}
