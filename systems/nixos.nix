args:
with args;
with mylib;
with allSystemAttrs; let
  base_args = {
    inherit home-manager; # inputs;
    # inherit nixpkgs; # or nixpkgs-stable
    nixpkgs = nixpkgs-unstable;
    system = x64_system;
    specialArgs = allSystemSpecialArgs.x64_system;
  };
in {
  nixosConfigurations = {
    # vm with hyprland compositor
    vm = nixosSystem (vm_modules // base_args);

    # docker-vm = nixosSystem (docker_vm_modules // base_args);

    docker-vm = nixosSystem (docker_vm_modules // base_args);

    # # wsl with hyprland compositor
    # wsl = nixosSystem (wsl_modules // base_args);

    # desktop with hyprland compositor
    #desktop = nixosSystem (desktop_modules // base_args);

    # laptop with hyprland compositor
    laptop = nixosSystem (laptop_modules // base_args);
  };
}
