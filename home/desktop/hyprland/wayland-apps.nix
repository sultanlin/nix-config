{
  pkgs,
  catppuccin-foot,
  anyrun,
  ...
}: let
  anyrunPackages = anyrun.packages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    (
      {modulesPath, ...}: {
        # Important! We disable home-manager's module to avoid option
        # definition collisions
        disabledModules = ["${modulesPath}/programs/anyrun.nix"];
      }
    )
    anyrun.homeManagerModules.default
  ];

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
      package = anyrunPackages.anyrun;
      config = {
        # The horizontal position.
        # when using `fraction`, it sets a fraction of the width or height of the screen
        x.fraction = 0.5; # at the middle of the screen
        # The vertical position.
        y.fraction = 0.05; # at the top of the screen
        # The width of the runner.
        width.fraction = 0.3; # 30% of the screen

        hideIcons = false;
        ignoreExclusiveZones = false;
        layer = "overlay";
        hidePluginInfo = false;
        closeOnClick = true;
        showResultsImmediately = true;
        maxEntries = null;

        # https://github.com/anyrun-org/anyrun/tree/master/plugins
        plugins = with anyrunPackages; [
          applications # Launch applications
          dictionary # Look up word definitions using the Free Dictionary API.
          nix-run # search & run graphical apps from nixpkgs via `nix run`, without installing it.
          # randr         # quickly change monitor configurations on the fly
          rink # A simple calculator plugin
          symbols # Look up unicode symbols and custom user defined symbols.
          translate # ":zh <text to translate>" Quickly translate text using the Google Translate API.
          # niri-focus # Search for & focus the window via title/appid on Niri
        ];
      };
      extraConfigFiles = {
        "symbols.ron".text = ''
          Config(
            // The prefix that the search needs to begin with to yield symbol results
            prefix: "",
            // Custom user defined symbols to be included along the unicode symbols
            symbols: {
              // "name": "text to be copied"
              "shrug": "¯\\_(ツ)_/¯",
            },
            max_entries: 3,
          )
        '';
        "applications.ron".text = ''
          Config(
            // Also show the Desktop Actions defined in the desktop files, e.g. "New Window" from LibreWolf
            desktop_actions: true,

            max_entries: 5,

            // The terminal used for running terminal based desktop entries, if left as `None` a static list of terminals is used
            // to determine what terminal to use.
            terminal: Some(Terminal(
              // The main terminal command
              command: "alacritty",
              // What arguments should be passed to the terminal process to run the command correctly
              // {} is replaced with the command in the desktop entry
              args: "-e {}",
            )),
          )
        '';
      };

      #   # custom css for anyrun, based on catppuccin-mocha
      #   extraCss = ''
      #             @define-color bg-col  rgba(30, 30, 46, 0.7);
      #           @define-color bg-col-light rgba(150, 220, 235, 0.7);
      #           @define-color border-col rgba(30, 30, 46, 0.7);
      #           @define-color selected-col rgba(150, 205, 251, 0.7);
      #           @define-color fg-col #D9E0EE;
      #           @define-color fg-col2 #F28FAD;
      #
      #           * {
      #     transition: 200ms ease;
      #                 font-family: "MonoLisa";
      #                 font-size: 1.3rem;
      #           }
      #
      #     #window {
      #     background: transparent;
      #     }
      #
      #     #plugin,
      #     #main {
      #     border: 3px solid @border-col;
      #     color: @fg-col;
      #            background-color: @bg-col;
      #     }
      #     /* anyrun's input window - Text */
      #     #entry {
      #     color: @fg-col;
      #            background-color: @bg-col;
      #     }
      #
      #     /* anyrun's output matches entries - Base */
      #     #match {
      #     color: @fg-col;
      #     background: @bg-col;
      #     }
      #
      #     /* anyrun's selected entry - Red */
      #     #match:selected {
      #     color: @fg-col2;
      #     background: @selected-col;
      #     }
      #
      #     #match {
      #     padding: 3px;
      #              border-radius: 16px;
      #     }
      #
      #     #entry, #plugin:hover {
      #       border-radius: 16px;
      #     }
      #
      #     box#main {
      #     background: rgba(30, 30, 46, 0.7);
      #     border: 1px solid @border-col;
      #             border-radius: 15px;
      #     padding: 5px;
      #     }
      #   '';
    };
  };

  xdg.configFile."anyrun/style.css".text = ''
    /* ===== Color variables ===== */
    :root {
      --bg-color: #313244;
      --fg-color: #cdd6f4;
      --primary-color: #89b4fa;
      --secondary-color: #cba6f7;
      --border-color: var(--primary-color);
      --selected-bg-color: var(--primary-color);
      --selected-fg-color: var(--bg-color);
    }

    /* ===== Global reset ===== */
    * {
      all: unset;
      font-family: "JetBrainsMono Nerd Font", monospace;
    }

    /* ===== Transparent window ===== */
    window {
      background: transparent;
    }

    /* ===== Main container ===== */
    box.main {
      border-radius: 16px;
      background-color: color-mix(in srgb, var(--bg-color) 80%, transparent);
      border: 0.5px solid color-mix(in srgb, var(--fg-color) 25%, transparent);
      padding: 12px; /* add uniform padding around the whole box */
    }

    /* ===== Input field ===== */
    text {
      font-size: 1.3rem;
      background: transparent;
      border: 1px solid var(--border-color);
      border-radius: 16px;
      margin-bottom: 12px;
      padding: 5px 10px;
      min-height: 44px;
      caret-color: var(--primary-color);
    }

    /* ===== List container ===== */
    .matches {
      background-color: transparent;
    }

    /* ===== Single match row ===== */
    .match {
      font-size: 1.1rem;
      padding: 4px 10px; /* tight vertical spacing */
      border-radius: 6px;
    }

    /* Remove default label margins */
    .match * {
      margin: 0;
      padding: 0;
      line-height: 1;
    }

    /* Selected / hover state */
    .match:selected,
    .match:hover {
      background-color: var(--selected-bg-color);
      color: var(--selected-fg-color);
    }

    .match:selected label.plugin.info,
    .match:hover label.plugin.info {
      color: var(--selected-fg-color);
    }

    .match:selected label.match.description,
    .match:hover label.match.description {
      color: color-mix(in srgb, var(--selected-fg-color) 90%, transparent);
    }

    /* ===== Plugin info label ===== */
    label.plugin.info {
      color: var(--fg-color);
      font-size: 1rem;
      min-width: 160px;
    }

    /* ===== Description label ===== */
    label.match.description {
      font-size: 0rem;
      color: var(--fg-color);
    }

    /* ===== Fade-in animation ===== */
    @keyframes fade {
      0% {
        opacity: 0;
      }
      100% {
        opacity: 1;
      }
    }
  '';
}
