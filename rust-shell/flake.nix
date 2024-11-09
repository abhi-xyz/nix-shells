{
  description = "A very basic flake"; # not really :)

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    unstable-nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    unstable-nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  }:
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
        formatter = pkgs.alejandra;
        devShells.default = import ./nix/shell.nix {inherit pkgs;};
        packages.${manifest.name} = pkgs.callPackage ./release/default.nix {}; # we are not passing any pkgs overlay to default.nix. so it will build the pkg using the stable default channel
        packages.default = self.packages.rid;
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
