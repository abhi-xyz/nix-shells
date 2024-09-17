{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    git
    gcc
    pkg-config
    gnumake
    gnupatch
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    ];
  shellHook = ''
    echo "Environment is ready" | ${pkgs.lolcat}/bin/lolcat;
  '';
}
