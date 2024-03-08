{
  inputs,
  config,
  pkgs,
  home-manager,
  home-module,
  specialArgs,
  system,
  ...
}: let
  inherit (specialArgs) username;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # home-manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.extraSpecialArgs = specialArgs;
  home-manager.users."${username}" = home-module;
}
