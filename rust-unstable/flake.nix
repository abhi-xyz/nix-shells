{
  description = "A very basic flake";

  inputs = {
    unstable-nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, unstable-nixpkgs }:
    let
      unstable-pkgs = unstable-nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShells.x86_64-linux.default = unstable-pkgs.mkShell {
        builtInputs = with unstable-pkgs; [
          neovim
          zed-editor
        ];
      };
      runcmd = "${unstable-pkgs.fish}/bin/fish ${unstable-pkgs.zed-editor}/bin/zed-editor";
    };
}
