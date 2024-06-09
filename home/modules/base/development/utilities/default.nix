{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.modules.base.development;
in
{
  config = lib.mkIf cfg.enable {
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
  };
}