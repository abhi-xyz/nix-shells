{ pkgs ? import <nixpkgs> {} }:
let
in
  pkgs.mkShell rec {
    buildInputs = with pkgs; [
      # libudev-zero
      inkscape-with-extensions
      gimp-with-plugins
      krita
    ];
    shellHook = ''
      export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
      '';
  }
