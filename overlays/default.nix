{
  inputs,
  ...
}:
{

  additions = final: prev: {
    # flake = import ../pkgs {
    #   pkgs = prev;
    #   inherit inputs;
    # };
  };

  modifications = final: prev: {
    # kubecm = prev.kubecm.overrideAttrs (_: prev: {
    #   meta = prev.meta // {
    #     mainProgram = "kubecm";
    #   };
    # });
  };

  # The unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
