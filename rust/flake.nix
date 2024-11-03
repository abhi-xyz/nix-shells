{
  description = "Flake template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, unstable-nixpkgs, flake-utils }: let
    system = "x86_64-linux";
    manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
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
    formatter.${system} = pkgs.alejandra;
    packages.${system} = {
      ${manifest.name} = let 
        rustPlatform = pkgs.rustPlatform;
        manifest = (pkgs.lib.importTOML ./Cargo.toml).package;
      in
        rustPlatform.buildRustPackage rec {
          pname = manifest.name;
          version = manifest.version;
          cargoLock.lockFile = ./Cargo.lock;
          src = pkgs.lib.cleanSource ./.;
          doCheck = false;

          meta = with pkgs.lib; {
            description = manifest.description;
            homepage = "https://github.com/abhi-xyz/${manifest.name}";
            changelog = "https://github.com/abhi-xyz/${manifest.name}/releases";
            license = licenses.mit;
            maintainers = with maintainers; [ Abhinandh S ];
            platforms = platforms.linux;
            mainProgram = manifest.name;
          };
        };
      default = self.packages.${system}.${manifest.name};
    };
    devShells.${system}.default = let
      overrides = builtins.fromTOML (builtins.readFile ./rust-toolchain.toml);
      libPath =
        with pkgs;
        lib.makeLibraryPath [
          # load external libraries that you need in your rust project here
        ];
    in pkgs.mkShell {
        buildInputs = with pkgs; [
          clang
          llvmPackages.bintools
          unstable.neovim
          unstable.rustup
          # jetbrains.rust-rover
          (writeShellScriptBin "ff"
            # bash
            ''
              ${fzf}/bin/fzf -e --cycle --walker-skip=.git,.direnv,target | xargs -r nvim
            ''
          )
          (writeShellScriptBin "fzfr"
            # bash
            ''
              ${fzf}/bin/fzf -e --cycle --walker-skip=.git,.direnv | xargs -r rm
            ''
          )
        ];
        RUSTC_VERSION = overrides.toolchain.channel;
        LIBCLANG_PATH = pkgs.lib.makeLibraryPath [ pkgs.llvmPackages_latest.libclang.lib ];
        shellHook = ''
          export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
          export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
          echo "Environment ready!" | ${pkgs.lolcat}/bin/lolcat
        '';
        RUSTFLAGS = builtins.map (a: ''-L ${a}/lib'') [
        ];
        LD_LIBRARY_PATH = libPath;
        BINDGEN_EXTRA_CLANG_ARGS =
          (builtins.map (a: ''-I"${a}/include"'') [
            pkgs.glibc.dev
          ])
          ++ [
            ''-I"${pkgs.llvmPackages_latest.libclang.lib}/lib/clang/${pkgs.llvmPackages_latest.libclang.version}/include"''
            ''-I"${pkgs.glib.dev}/include/glib-2.0"''
            ''-I${pkgs.glib.out}/lib/glib-2.0/include/''
          ];
      };
  };
}
