{
  pkgs,
  pkgs-unstable,
  catppuccin-cava,
  ...
}:
# media - control and enjoy audio/video
{
  home.packages = with pkgs; [
    # audio control
    pavucontrol
    playerctl
    pulsemixer
    imv # simple image viewer

    # GPU task monitoring, disable it if you don't need it
    # Increases nix build time by a lot (installs cuda)
    # nvtop # htop for GPUs (nvidia/amd/intel), builds cuda, takes too long

    # video/audio tools
    cava # for visualizing audio
    libva-utils
    vdpauinfo
    vulkan-tools
    glxinfo
  ];

  # https://github.com/catppuccin/cava
  xdg.configFile."cava/config".text =
    ''
      # custom cava config
    ''
    + builtins.readFile "${catppuccin-cava}/mocha.cava";

  programs = {
    mpv = {
      enable = true;
      # defaultProfiles = ["gpu-hq"];
      # scripts = [pkgs.mpvScripts.mpris];
    };
  };

  services = {
    playerctld.enable = true;
  };
}
