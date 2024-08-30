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
    (wrapHelm kubernetes-helm {
        plugins = with pkgs.kubernetes-helmPlugins; [
          helm-secrets
          helm-diff
          helm-s3
          helm-git
        ];
      })
    helmfile
    lens
    # Unstable packages
    unstable.talosctl

    # Flake packages
    inputs.talhelper.packages.${system}.default
  ];
}
