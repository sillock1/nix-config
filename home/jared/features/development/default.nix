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
      pre-commit
      shellcheck
      shfmt
      yamllint

      go
      stern
      goss
      dgoss
      python3Full
      golangci-lint
      ansible
      python312Packages.molecule
      python312Packages.molecule-plugins
      python312Packages.docker
      # Unstable packages
      unstable.mise
      unstable.uv
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
