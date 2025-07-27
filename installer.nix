{ pkgs, package }:

pkgs.writeShellScriptBin "install-inferno" ''
  cp -r ${package}/inferno $1
  sudo chmod -R 775 $1
''
