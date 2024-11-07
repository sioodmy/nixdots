{
  description = "Consequence of allowing autistic people on the internet. Stay mad one-proper-config-structure purists :3";

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        nixosModules =
          {
            # This module is not meant to be imported by anyone but me
            # it's just so I can easily avoid ../../../../../ mess
            system = import ./system;

            user = let
              theme = import ./theme;
              user = import ./user {inherit theme;};
            in
              user.module;

            # place for my home brew modules
          }
          // import ./modules;
        nixosConfigurations = import ./hosts inputs;
      };
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      perSystem = {pkgs, ...}: let
        theme = import ./theme;
        user = import ./user {
          inherit pkgs theme;
        };
      in {
        formatter = pkgs.alejandra;
        packages = user.packages;
        devShells.default = user.shell;
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    apple-silicon-support = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
