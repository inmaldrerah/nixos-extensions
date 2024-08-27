{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs, ... }:
    {
      packages."x86_64-linux" = {
        switch-to-configuration-ng =
          nixpkgs.legacyPackages."x86_64-linux".callPackage
            ./pkgs/switch-to-configuration-ng/package.nix {};
      };
    };
}
