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
      ${system} = rec {
        inferno = callPackage ./package.nix { 
          name = "inferno";
          version = "4.0";
        };
        default = callPackage ./installer.nix { package = inferno; };
      };
    };
    devShells.${system}.default = callPackage ./shell.nix { };
  };
}
