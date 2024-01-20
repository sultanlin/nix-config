{
  pkgs,
  config,
  specialArgs,
  ...
}: {
  imports = [
    # ./edge.nix
    # ./chrome.nix
    # ./qutebrowser.nix
    # ./firefox.nix
  ];

  home.packages = with pkgs; [
    firefox
    # google-chrome
    vivaldi
    brave
    microsoft-edge
  ];

  programs = {
    # source code: https://github.com/nix-community/home-manager/blob/master/modules/programs/chromium.nix
    google-chrome = {
      enable = true;

      commandLineArgs = [
        # make it use GTK_IM_MODULE if it runs with Gtk4, so fcitx5 can work with it.
        # (only supported by chromium/chrome at this time, not electron)
        "--gtk-version=4"
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
        # make it use text-input-v1, which works for kwin 5.27 and weston
        "--enable-wayland-ime"

        # enable hardware acceleration - vulkan api
        # "--enable-features=Vulkan"
      ];
    };
  };
}
