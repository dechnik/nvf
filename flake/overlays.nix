{
  inputs,
  pkgs,
  ...
}: let
  inherit (import ../configuration.nix inputs) neovimConfiguration mainConfig ldConfig;

  buildPkg = pkgs: modules: (neovimConfiguration {inherit pkgs modules;}).neovim;

  nixConfig = mainConfig false;
  maximalConfig = mainConfig true;
in {
  flake.overlays.default = _final: prev: {
    inherit neovimConfiguration;
    neovim-nix = buildPkg prev [nixConfig];
    neovim-maximal = buildPkg prev [maximalConfig];
    neovim-ld = buildPkg prev [ldConfig];
    devPkg = buildPkg pkgs [nixConfig {config.vim.languages.html.enable = pkgs.lib.mkForce true;}];
  };
}
