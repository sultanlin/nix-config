{
  nixpkgs,
  home-manager,
  system,
  specialArgs,
  nixos-modules,
  home-module,
}: let
  inherit (specialArgs) username;
in
  nixpkgs.lib.nixosSystem {
    inherit system specialArgs;
    modules =
      nixos-modules;
    # ++ [
    # nixos-generators.nixosModules.all-formats
    # {
    #   # formatConfigs.iso = {config, ...}: {};
    #   formatConfigs.proxmox = {config, ...}: {
    #     # custom proxmox's image name
    #     proxmox.qemuConf.name = "${config.networking.hostName}-nixos-${config.system.nixos.label}";
    #   };
    # }
    #

    # Home manager as a NixOS module
    # home-manager.nixosModules.home-manager
    # {
    #   home-manager.useGlobalPkgs = true;
    #   home-manager.useUserPackages = true;
    #
    #   home-manager.extraSpecialArgs = specialArgs;
    #   home-manager.users."${username}" = home-module;
    # }
    # ];

    # Home manager as a standalone
    # home-manager = {
    #   home-manager.useGlobalPkgs = true;
    #   home-manager.useUserPackages = true;
    #
    #   home-manager.extraSpecialArgs = specialArgs;
    #   home-manager.users."${username}" = home-module;
    # };
  }
