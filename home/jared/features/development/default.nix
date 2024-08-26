{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    cue
    nixd
    nixfmt-rfc-style
    pre-commit
    shellcheck
    shfmt
    yamllint
    restic
    kubectl
    envsubst
    sops
    ssh-to-age
    helmfile

    # Unstable packages
    unstable.talosctl

    # Flake packages
    inputs.talhelper.packages.${system}.default
  ];
}
