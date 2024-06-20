{lib, ...}: let
  inherit (lib.meta) getExe;
in {
  perSystem = {config, ...}: {
    apps = {
      nix.program = getExe config.packages.nix;
      maximal.program = getExe config.packages.maximal;
      ld.program = getExe config.packages.ld;
      default = config.apps.nix;
    };
  };
}
