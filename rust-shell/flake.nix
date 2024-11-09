{
  description = "A very basic flake"; # not really :)

  inputs = {
    #  NOTE: checked
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    unstable-nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    #  NOTE: checked
    self,
    nixpkgs,
    unstable-nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  }:
    #  NOTE: checked
    flake-utils.lib.eachDefaultSystem (
      system: let
        manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
        overlays = [
          (import rust-overlay)
          (final: prev: {
            unstable = import unstable-nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          })
        ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in {
        #  FIX: unchecked
        # checks.test01 = derivation;
        #  NOTE: checked
        formatter = pkgs.alejandra;
        #  NOTE: checked
        devShells.default = import ./nix/dev/shell.nix {inherit pkgs;};
        #  FIX: unchecked
        packages = {
          # we are not passing any pkgs overlay to default.nix
          # so it will build the pkg using the stable default channel
          ${manifest.name} = pkgs.callPackage ./nix/release/default.nix {};
          default = pkgs.callPackage ./nix/release/default.nix { };
        }; 
        #  FIX: unchecked
        /*
packages.${system} = {
${manifest.name} = pkgs.callPackage ./nix/default.nix;
# Executed by `nix build .`
default = pkgs.callPackage ./nix/default.nix;
};
homeManagerModules.${manifest.name} = pkgs.callPackage ./nix/home-module.nix;
homeManagerModules.default = self.homeManagerModules.${manifest.name};

nixosModules.${manifest.name} = { config, ... }: { options = {}; config = {}; };
nixosModules.default = { config, ... }: { options = {}; config = {};
*/
      }
    );
}
