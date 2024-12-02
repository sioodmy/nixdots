{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  mkHost = name: system:
    nixpkgs.lib.nixosSystem {
      modules =
        [
          {
            networking.hostName = name;
            nixpkgs.hostPlatform = system;
          }
          ./${name}
        ]
        ++ builtins.attrValues self.nixosModules;

      # This allows to easily access flake inputs and outputs
      # from nixos modules, so it's a little bit cleaner
      specialArgs = {
        inherit inputs;
        theme = (import ../user).theme nixpkgs.legacyPackages.${system};
        flake = self;
      };
    };
in {
  calypso = mkHost "calypso" "x86_64-linux";
  pandora = mkHost "pandora" "aarch64-linux";
}
