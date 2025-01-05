{
  description = "Consequence of allowing autistic people on the internet. Stay mad one-proper-config-structure purists :3";

  outputs = inputs @ {nixpkgs, ...}: let
    user = import ./user;

    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in {
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in (user.packages pkgs)
    );

    formatter = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        pkgs.alejandra
    );

    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {default = user.shell pkgs;}
    );
    nixosModules =
      {
        # This module is not meant to be imported by anyone but me
        # it's just so I can easily avoid ../../../../../ mess
        system = import ./system;

        user = user.module;

        # place for my home brew modules
      }
      // import ./modules;

    nixosConfigurations = import ./hosts inputs;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    apple-silicon-support.url = "github:tpwrules/nixos-apple-silicon";
  };
}
