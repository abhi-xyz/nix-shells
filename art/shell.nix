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
    RUSTC_VERSION = overrides.toolchain.channel;
    # https://github.com/rust-lang/rust-bindgen#environment-variables
    LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
    shellHook = ''
      export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
      '';
  }
