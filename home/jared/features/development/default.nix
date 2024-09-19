{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./vscode.nix
    ./lens.nix
    ./jetbrains.nix
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
    fluxcd
    dotnetCorePackages.sdk_8_0_2xx
    # Unstable packages
    unstable.talosctl
    unstable.sops
    unstable.podman-compose
    # Flake packages
    inputs.talhelper.packages.${system}.default
  ];

  home.file = {
    "/run/user/1000/podman/podman.sock".source = config.lib.file.mkOutOfStoreSymlink "/run/user/1000/docker.sock";
  };
}
