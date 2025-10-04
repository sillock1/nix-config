{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./vscode.nix
  ];

  home = {
    packages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];

    #virt-manager persistence
    persistence."/persist/home/${config.home.username}" = {
      directories = [
        ".config/dconf"
        ".config/containers"
      ];
    };
  };
}
