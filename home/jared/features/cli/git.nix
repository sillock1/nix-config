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
    package = pkgs.gitFull;
    lfs.enable = true;
    ignores = [
      ".direnv"
      "result"
    ];
    includes = [{
      contents = {
        user = {
          name = "sillock";
          email = "mail@sillock.com";
          signingKey = "5922765DA44FED87F98EE2FBA4572BEA3D629397!";
        };
      };
    }];
    settings = {
      aliases = {
        p = "pull --ff-only";
      };
      extraConfig = {
        init.defaultBranch = "main";
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
    };
  };
}
