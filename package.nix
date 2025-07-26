{ pkgs, name, version }:

pkgs.stdenv.mkDerivation rec {
  inherit name version;
  src = pkgs.fetchFromGitHub {
    owner = "inferno-os";
    repo = "inferno-os";
    rev = "2279329";
    hash = "sha256-V2paOjoiZkP6Wl1eOppw+wFSeKsmCYSySxH+gwS1gEg=";
    fetchSubmodules = true;
  };
  buildInputs = with pkgs; [
    xorg.libX11
    xorg.libXext
  ];
  buildPhase = ''
    export ROOT=$PWD
    export PATH=$PATH:$ROOT/Linux/386/bin
    echo ROOT=$ROOT > mkconfig
    echo TKSTYLE=std >> mkconfig
    echo SYSHOST=Linux >> mkconfig
    echo SYSTARG=Linux >> mkconfig
    echo OBJTYPE=386 >> mkconfig
    echo 'OBJDIR=$SYSTARG/$OBJTYPE' >> mkconfig
    echo '<$ROOT/mkfiles/mkhost-$SYSHOST' >> mkconfig
    echo '<$ROOT/mkfiles/mkfile-$SYSTARG-$OBJTYPE' >> mkconfig
    sh makemk.sh
    mk mkdirs
    mk nuke
    mk install
    sed -i '1s|.*|#!/dis/sh.dis|' dis/{broke,lc,lookman,man,shutdown,sig}
  '';
  installPhase = ''
    mkdir -p $out/inferno
    cp -r * $out/inferno
  '';
}
