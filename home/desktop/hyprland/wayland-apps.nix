{
  pkgs,
  catppuccin-foot,
  anyrun,
  ...
}: {
  # refer to https://codeberg.org/dnkl/foot/src/branch/master/foot.ini
  xdg.configFile."foot/foot.ini".text =
    ''
      [main]
      dpi-aware=yes
      font=JetBrainsMono Nerd Font:size=13
      shell=${pkgs.bash}/bin/bash --login -c 'nu --login --interactive'
      term=foot
      initial-window-size-pixels=3840x2160
      initial-window-mode=windowed
      pad=0x0                             # optionally append 'center'
      resize-delay-ms=10

      [mouse]
      hide-when-typing=yes
    ''
    + (builtins.readFile "${catppuccin-foot}/themes/catppuccin-mocha.ini");

  programs = {
    # a wayland only terminal emulator
    foot = {
      enable = true;
      # foot can also be run in a server mode. In this mode, one process hosts multiple windows.
      # All Wayland communication, VT parsing and rendering is done in the server process.
      # New windows are opened by running footclient, which remains running until the terminal window is closed.
      #
      # Advantages to run foot in server mode including reduced memory footprint and startup time.
      # The downside is a performance penalty. If one window is very busy with, for example, producing output,
      # then other windows will suffer. Also, should the server process crash, all windows will be gone.
      server.enable = true;
    };

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

    firefox = {
      enable = true;
      enableGnomeExtensions = false;
      # package = pkgs.firefox-wayland; # firefox with wayland support
      package = pkgs.firefox; # firefox with wayland support
    };

    anyrun = {
      enable = true;
      config = {
        plugins = with anyrun.packages.${pkgs.system}; [
          applications
          randr
          rink
          shell
          symbols
          translate
        ];

        width.fraction = 0.3;
        y.absolute = 15;
        hidePluginInfo = true;
        closeOnClick = true;
      };

      # custom css for anyrun, based on catppuccin-mocha
      extraCss = ''
        @define-color bg-col  rgba(30, 30, 46, 0.7);
        @define-color bg-col-light rgba(150, 220, 235, 0.7);
        @define-color border-col rgba(30, 30, 46, 0.7);
        @define-color selected-col rgba(150, 205, 251, 0.7);
        @define-color fg-col #D9E0EE;
        @define-color fg-col2 #F28FAD;

        * {
          transition: 200ms ease;
          font-family: "Maple Mono NF CN";
          font-size: 1.3rem;
        }

        #window {
          background: transparent;
        }

        #plugin,
        #main {
          border: 3px solid @border-col;
          color: @fg-col;
          background-color: @bg-col;
        }
        /* anyrun's input window - Text */
        #entry {
          color: @fg-col;
          background-color: @bg-col;
        }

        /* anyrun's output matches entries - Base */
        #match {
          color: @fg-col;
          background: @bg-col;
        }

        /* anyrun's selected entry - Red */
        #match:selected {
          color: @fg-col2;
          background: @selected-col;
        }

        #match {
          padding: 3px;
          border-radius: 16px;
        }

        #entry, #plugin:hover {
          border-radius: 16px;
        }

        box#main {
          background: rgba(30, 30, 46, 0.7);
          border: 1px solid @border-col;
          border-radius: 15px;
          padding: 5px;
        }
      '';
    };
  };
}
