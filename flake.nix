{
  description = "sillock's Nix Flake";

  inputs = {
    # Nixpkgs and unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust toolchain overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };

    # deploy-rs
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # sops-nix
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-inspect.url = "github:bluskript/nix-inspect";

    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-inspect,
    deploy-rs,
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
        vm = mkSystemLib.mkNixosSystem "x86_64-linux" "vm" overlays flake-packages;
      };

  } // import ./deploy.nix inputs;
}