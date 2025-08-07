{
  pkgs,
  config,
  lib,
  ...
}:
let
  ssh = "${pkgs.openssh}/bin/ssh";
in
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      p = "pull --ff-only";
    };
    userName = "sillock";
    userEmail = lib.mkDefault "mail@sillock.com";
    extraConfig = {
      init.defaultBranch = "main";
      user.signing.key = "5922765DA44FED87F98EE2FBA4572BEA3D629397!";
      commit.gpgSign = lib.mkDefault true;
      gpg.program = "gpg2";

      merge.conflictStyle = "zdiff3";
      commit.verbose = true;
      diff.algorithm = "histogram";
      log.date = "iso";
      column.ui = "auto";
      branch.sort = "committerdate";
      # Automatically track remote branch
      push.autoSetupRemote = true;
      # Reuse merge conflict fixes when rebasing
      rerere.enabled = true;
    };
    lfs.enable = true;
    ignores = [
      ".direnv"
      "result"
    ];
  };
}
