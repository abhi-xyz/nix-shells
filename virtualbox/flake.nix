{
  description = "A Nix-flake-based hugo development environment";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
        });
  in {
    allowUnfree = true;
    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          neovim
          virt-manager
          libvirt
          qemu_full
          adwaita-qt
        ];
        shellHook = ''
          export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
          echo "Environment ready!" | ${pkgs.lolcat}/bin/lolcat
        '';
        runcmd = "fish";
      };
    });
  };
}
