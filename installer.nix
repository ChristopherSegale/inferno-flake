{ pkg, package }:

pkg.writeShellScriptBin "install-inferno" ''
  cp -r ${package}/inferno $1
  sudo chmod -R 775 $1
'';
