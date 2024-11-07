{
  description = "Flake template";

  inputs = {
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { self, nixpkgs, unstable-nixpkgs, emacs-overlay }: let
    system = "x86_64-linux";
    emacsOverlay = import emacs-overlay;
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
        (aspellWithDicts (dicts: with dicts; [ en en-computers en-science es]))
        (pkgs.emacsWithPackagesFromUsePackage {
          config = ./init.el;
          defaultInitFile = true;
          package = pkgs.emacs;
          alwaysEnsure = true;
          alwaysTangle = true;
          # packageElisp = builtins.readFile ./lisp/themes/elegant.el;
          extraEmacsPackages = epkgs: with epkgs; [
            # lsp 
            auctex
            cask
            doom-modeline
            doom-themes
            evil
            neotree
            treemacs
            vertico
            # savehist
            marginalia
            embark
            consult
            orderless
            corfu
            cape
            which-key
            org
            htmlize
            rust-mode
            eglot
            yasnippet-snippets
            dashboard
            doom-modeline
            evil
            evil-collection
            all-the-icons
            nerd-icons
            general
            org-roam
            embark-consult
            el-patch
            magit
            org-roam
            ispell
            rainbow-mode
            rainbow-delimiters
          ];
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
