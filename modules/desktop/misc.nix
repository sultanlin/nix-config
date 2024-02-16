{
  config,
  lib,
  pkgs,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    obsidian
    # ventoy
    # gnumake
    #
    # colmena # nixos's remote deployment tool
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
}
