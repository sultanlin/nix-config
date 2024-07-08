let
  desktop_base_modules = {
    nixos-modules = [
      # ../modules/nixos/desktop.nix
      ../modules/hyprland.nix
    ];
    home-module.imports = [
      ../home/desktop.nix
    ];
  };
in {
  laptop_modules = {
    nixos-modules =
      [
        ../hosts/laptop
        # {modules.desktop.wayland.enable = true;}
      ]
      ++ desktop_base_modules.nixos-modules;
    home-module.imports =
      [
        ../hosts/laptop/home.nix
        # {modules.desktop.hyprland.enable = true;}
        <catppuccin/modules/nixos>
      ]
      ++ desktop_base_modules.home-module.imports;
  };
  vm_modules = {
    nixos-modules = [
      ../hosts/vm
      ../modules/server.nix
      # ../modules/nixos/proxmox-hardware-configuration.nix
    ];
    home-module.imports = [
      ../hosts/vm/home.nix
      ../home/server.nix
    ];
  };
  docker_vm_modules = {
    nixos-modules = [
      ../hosts/docker-vm
      ../modules/server.nix
      ../modules/proxmox-hardware-configuration.nix
    ];
    home-module.imports = [
      ../hosts/docker-vm/home.nix
      ../home/server.nix
    ];
  };
}
