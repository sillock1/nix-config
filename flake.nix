{
  description = "sillock's Nix Flake";

  inputs = {
    # Nixpkgs and unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust toolchain overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };

    # sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-inspect.url = "github:bluskript/nix-inspect";

    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    swww.url = "github:LGFae/swww";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-inspect,
    sops-nix,
    rust-overlay,
    ...
  } @inputs:
  let
    supportedSystems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    overlays = import ./overlays {inherit inputs;};
    mkSystemLib = import ./lib/mkSystem.nix {inherit inputs;};
    flake-packages = self.flake-packages;

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
        system: let
          pkgs = legacyPackages.${system};
        in
          import ./pkgs {
            inherit pkgs;
            inherit inputs;
          }  
      );

      nixosConfigurations = {
        deimos = mkSystemLib.mkNixosSystem "x86_64-linux" "deimos" overlays flake-packages;
        desktop-vm = mkSystemLib.mkNixosSystem "x86_64-linux" "desktop-vm" overlays flake-packages;
        server-vm = mkSystemLib.mkNixosSystem "x86_64-linux" "server-vm" overlays flake-packages;
      };

  };
}