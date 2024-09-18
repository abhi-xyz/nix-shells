{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {

  buildInputs = with pkgs; [
    pyright
    python311Packages.pip
    python311Packages.pypresence
  ];
  shellHook = ''
    echo "Environment is ready" | ${pkgs.lolcat}/bin/lolcat;
    '';
}
