{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    libreoffice-fresh
    
  ];
  shellHook = ''
    echo "Environment is ready" | ${pkgs.lolcat}/bin/lolcat;
  '';
}
