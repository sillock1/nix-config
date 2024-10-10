{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./dotnet.nix
    ./jetbrains.nix
    ./lens.nix
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
      docker-compose
      crane
      postgresql
      # Unstable packages
      unstable.talosctl
      unstable.sops
      unstable.podman-compose
      unstable.kind
      # Flake packages
      inputs.talhelper.packages.${system}.default
    ];

    file = {
      "/run/user/1000/podman/podman.sock".source = config.lib.file.mkOutOfStoreSymlink "/run/user/1000/docker.sock";
    };
    #virt-manager persistence
    persistence."/persist/home/${config.home.username}" = {
      directories = [".config/dconf"];
    };
  };
}
