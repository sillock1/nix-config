{ 
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
  ];
}