{ pkgs }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    xorg.libX11
    xorg.libXext
  ];
}
