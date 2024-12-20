{
  description = "Flake template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, unstable-nixpkgs }: let
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
        unstable.kdenlive
        unstable.neovim
        unstable.gimp-with-plugins
        unstable.inkscape-with-extensions
        krita
      ];
      shellHook = ''
        echo "Environment ready!" | ${pkgs.lolcat}/bin/lolcat
      '';
    };
  };
}
