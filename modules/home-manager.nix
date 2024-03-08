{
  inputs,
  config,
  pkgs,
  home-manager,
  home-module,
  specialArgs,
  system,
  constants,
  mylib,
  ...
}: let
  inherit (specialArgs) username;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    # extraSpecialArgs = specialArgs;
    extraSpecialArgs = {
      inherit (constants) username userfullname useremail dotfilesConfig dotfilesConfigPath nixosPath;
      inherit mylib;
      # use unstable branch for some packages to get the latest updates
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system; # refer the `system` parameter form outer scope recursively
        # To use chrome, we need to allow the installation of non-free software
        config.allowUnfree = true;
      };
    };
    users."${username}" = home-module;
  };
  # home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
  #
  # home-manager.extraSpecialArgs = specialArgs;
  # home-manager.users."${username}" = home-module;
}
