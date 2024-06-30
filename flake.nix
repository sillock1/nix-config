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

    #Temporary impermanence module until upstream is updated
    impermanence.url = "github:misterio77/impermanence";
    #impermanence.url = "github:nix-community/impermanence";
    
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
    home-manager,
    systems,
    ...
  } @inputs:
  let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      overlays = import ./overlays {inherit inputs outputs;};

      packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});

      nixosConfigurations = {
        deimos-vm = lib.nixosSystem {
          modules = [./hosts/deimos-vm];
          specialArgs = {
            inherit inputs outputs;
          };
        };

        desktop-vm = lib.nixosSystem {
          modules = [
            ./hosts/desktop-vm
            inputs.disko.nixosModules.disko
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };

        server-vm = lib.nixosSystem {
          modules = [
            ./hosts/server-vm
            inputs.disko.nixosModules.disko
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };
  };
}