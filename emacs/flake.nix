{
  description = "Flake template";

  inputs = {
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, unstable-nixpkgs, emacs-overlay }: let
    system = "x86_64-linux";
    emacsOverlay = import self.inputs.emacs-overlay;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        emacsOverlay
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
        (pkgs.emacsWithPackagesFromUsePackage {
          config = ./init.el;

          # Whether to include your config as a default init file.
          # If being bool, the value of config is used.
          # Its value can also be a derivation like this if you want to do some
          # substitution:
          # defaultInitFile = pkgs.substituteAll {
          #   name = "default.el";
          #   src = ./init.el;
          #   #   inherit (config.xdg) configHome dataHome;
          # };
          defaultInitFile = true;

          package = pkgs.emacs;
          alwaysEnsure = true;
          alwaysTangle = true;
          packageElisp = builtins.readFile ./lisp/themes/elegant.el;
          extraEmacsPackages = epkgs: with epkgs; [
            cask
            evil
          ];

          # Optionally override derivations.
          override = final: prev: {
            weechat = prev.melpaPackages.weechat.overrideAttrs(old: {
              patches = [ ./weechat-el.patch ];
            });
          };
        })
      ];
      shellHook = ''
        echo "Environment ready!" | ${pkgs.lolcat}/bin/lolcat
        '';
    };
  };
}
