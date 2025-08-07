{
  description = "sillock's Nix Flake";

  inputs = {
    # Nixpkgs and unstable
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-inspect.url = "github:bluskript/nix-inspect";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      ...
    }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      overlays = import ./overlays { inherit inputs; };
      mkSystemLib = import ./lib/mkSystem.nix { inherit inputs overlays; };
      flake-packages = self.packages;

      legacyPackages = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = builtins.attrValues overlays;
          config.allowUnfree = true;
        }
      );
    in
    {
      inherit overlays;

      packages = forAllSystems (
        system:
        let
          pkgs = legacyPackages.${system};
        in
        import ./pkgs {
          inherit pkgs;
          inherit inputs;
        }
      );
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
      nixosConfigurations = {
        luna = mkSystemLib.mkNixosSystem "x86_64-linux" "luna" flake-packages;
        deimos = mkSystemLib.mkNixosSystem "x86_64-linux" "deimos" flake-packages;
        sgr = mkSystemLib.mkNixosSystem "x86_64-linux" "sgr" flake-packages;
      };
    };
}
