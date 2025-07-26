{
  description = "Derivation for hosted Inferno";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };

  outputs = inputs @ { self, nixpkgs }:
  let
    system = "i686-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.replaceStdenv = { pkgs }: pkgs.gcc6Stdenv;
    };
    inherit (pkgs) callPackage;
  in {
    packages = {
      ${system}.default = callPackage ./package.nix { 
        name = "inferno";
        version = "4.0";
      };
    };
    devShells.${system}.default = callPackage ./shell.nix { };
  };
}
