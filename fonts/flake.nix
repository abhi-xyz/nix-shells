{
  description = "Flake template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    unstable-nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          unstable = import unstable-nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        })
      ];
    };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
        unstable.neovim
        (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/abhi-xyz/nix-fonts/refs/heads/master/fonts/lora/default.nix";
          sha256 = "sha256-f2mulc5ym/VAcp/mMUQ/W8C2qbs1HWHuAxPgOrG1lIU=";
        })
      ];
        shellHook = ''
        echo "Environment ready!" | ${pkgs.lolcat}/bin/lolcat
        '';
      };
    };
}
