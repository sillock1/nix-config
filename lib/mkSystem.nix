{
  inputs,
  overlays,
  ...
}:
{
  mkNixosSystem =
    system: hostname: flake-packages:
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
            extraSpecialArgs = {
              inherit inputs hostname flake-packages;
            };
          };
        }
        ../modules/nixos
        ../hosts/${hostname}
        ../modules/home-manager
      ];
      specialArgs = {
        inherit inputs hostname;
      };
    };
}
