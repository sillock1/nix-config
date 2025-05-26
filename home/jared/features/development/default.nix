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
      cue
      nixd
      nixfmt-rfc-style
      pre-commit
      shellcheck
      shfmt
      yamllint
      restic
      kubectl
      (wrapHelm kubernetes-helm {
          plugins = with pkgs.kubernetes-helmPlugins; [
            helm-secrets
            helm-diff
            helm-s3
            helm-git
          ];
        })
      helmfile
      go
      minijinja
      go-task
      fluxcd
      crane
      postgresql
      k9s
      stern
      goss
      dgoss
      python3Full
      golangci-lint
      ansible
      # Unstable packages
      unstable.opentofu
      unstable.chart-testing # Helm chart testing
      unstable.yq-go
      unstable.kustomize
      unstable.talosctl
      unstable.sops
      unstable.kind
      unstable.mise
      unstable.uv
      unstable.cilium-cli
      unstable.hubble
      # Flake packages
      inputs.talhelper.packages.${system}.default
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
