{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./vscode.nix
    ./lens.nix
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
    go-task
    # Unstable packages
    unstable.talosctl
    unstable.sops
    # Flake packages
    inputs.talhelper.packages.${system}.default
  ];
}
