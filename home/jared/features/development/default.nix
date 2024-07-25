{...}:
{
  imports = [
    ./rider.nix
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
  ];
}