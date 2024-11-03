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
        unstable.deno
        unstable.neovim
        clang
        llvmPackages.bintools
        tailwindcss-language-server
        # (vscode-with-extensions.override {
        # vscodeExtensions = with vscode-extensions; [
        # bbenoist.nix
        # jnoortheen.nix-ide
        # b4dm4n.vscode-nixpkgs-fmt
        # github.vscode-github-actions
        # formulahendry.auto-close-tag
        # davidlday.languagetool-linter
        # davidanson.vscode-markdownlint
        # catppuccin.catppuccin-vsc-icons
        # vspacecode.whichkey
        # vadimcn.vscode-lldb
        # skyapps.fish-vscode
        # ms-vscode.hexeditor
        # bungcip.better-toml
        # valentjn.vscode-ltex
        # sumneko.lua
        # redhat.vscode-xml
        # golang.go
        # mkhl.direnv
        # jock.svg
        # skellock.just
        # tal7aouy.icons
        # ban.spellright
        # serayuzgur.crates
        # enkia.tokyo-night
        # zaaack.markdown-editor
        # thorerik.hacker-theme
        # mskelton.one-dark-theme
        # catppuccin.catppuccin-vsc
        # yzhang.markdown-all-in-one
        # oderwat.indent-rainbow
        # techtheawesome.rust-yew
        # rust-lang.rust-analyzer
        # bradlc.vscode-tailwindcss
        # asvetliakov.vscode-neovim
        # ];
        # })
      ];
      shellHook = ''
        echo "Environment ready!" | ${pkgs.lolcat}/bin/lolcat
      '';
    };
  };
}
