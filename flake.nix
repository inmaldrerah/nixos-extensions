{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs, ... }:
    rec {
      packages."x86_64-linux" = {
        shell =
          nixpkgs.legacyPackages."x86_64-linux".callPackage
            ./pkgs/shell/package.nix {};
      };

      overlays.default = final: prev: {
        shell = prev.callPackage ./pkgs/shell/package.nix {};
      };

      nixosModules = rec {
        shell = { config, lib, pkgs, ... }: {
          options.programs.shell = {
            enable = lib.mkEnableOption "shell";
            package = lib.mkPackageOption pkgs "shell" {};
          };

          config = let
            cfg = config.programs.shell;
          in lib.mkIf cfg.enable {
            environment.shells = [
              "/run/current-system/sw/bin/shell-starter"
              "${lib.getExe cfg.package}"
            ];
            environment.systemPackages = [
              cfg.package
            ];
          };
        };
        default = shell;
      };
    };
}
