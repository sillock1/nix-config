{
  inputs,
  ...
}:
{
  mkNixosSystem = system: hostname: overlays: flake-packages:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues overlays;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
      modules = [
        {
          nixpkgs.hostPlatform = system;
          _module.args = {
            inherit inputs flake-packages;
          };
        }
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            sharedModules = [
              inputs.sops-nix.homeManagerModules.sops
            ];
            extraSpecialArgs = {
              inherit inputs hostname flake-packages;
            };
            users.jared = ../. + "/home/jared";
          };
        }
        inputs.disko.nixosModules.disko
        inputs.impermanence.nixosModules.impermanence
        ../hosts/${hostname}
      ];
      specialArgs = {
        inherit inputs hostname;
      };
    };
}