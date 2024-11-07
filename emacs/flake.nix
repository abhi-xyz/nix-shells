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
        unstable.neovim
        clang
        (aspellWithDicts (dicts: with dicts; [ en en-computers en-science es]))
        (emacs.override {
          # Use gtk3 instead of the default gtk2
          withGTK3 = true;
          withGTK2 = false;
        }).overrideAttrs (attrs: {
          # I don't want emacs.desktop file because I only use
          # emacsclient.
          postInstall = (attrs.postInstall or "") + ''
      rm $out/share/applications/emacs.desktop
          '';
        })
      ];
      shellHook = ''
        echo "Environment ready!" | ${pkgs.lolcat}/bin/lolcat
        '';
    };
  };
}
