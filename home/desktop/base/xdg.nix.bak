# XDG stands for "Cross-Desktop Group", with X used to mean "cross".
# It's a bunch of specifications from freedesktop.org intended to standardize desktops and
# other GUI applications on various systems (primarily Unix-like) to be interoperable:
#   https://www.freedesktop.org/wiki/Specifications/
{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    xdg-utils # provides cli tools such as `xdg-mime` `xdg-open`
    xdg-user-dirs
  ];

  xdg.configFile."mimeapps.list".force = true;
  # xdg.configFile."hypr" = {
  #   source = "${config_sym_dir}/hypr/hyprland.conf";
  #   recursive = true;
  # };

  xdg = {
    enable = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    # manage $XDG_CONFIG_HOME/mimeapps.list
    # xdg search all desktop entries from $XDG_DATA_DIRS, check it by command:
    #  echo $XDG_DATA_DIRS
    # the system-level desktop entries can be list by command:
    #   ls -l /run/current-system/sw/share/applications/
    # the user-level desktop entries can be list by command(user ryan):
    #  ls /etc/profiles/per-user/ryan/share/applications/
    mimeApps = {
      enable = true;
      defaultApplications = let
        browser = ["google-chrome.desktop"];
      in {
        "application/json" = browser;
        "application/pdf" = browser; # TODO: pdf viewer

        "text/html" = browser;
        "text/xml" = browser;
        "application/xml" = browser;
        "application/xhtml+xml" = browser;
        "application/xhtml_xml" = browser;
        "application/rdf+xml" = browser;
        "application/rss+xml" = browser;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;

        "x-scheme-handler/about" = browser;
        "x-scheme-handler/ftp" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/unknown" = browser;

        "x-scheme-handler/discord" = ["discord.desktop"];
        "x-scheme-handler/tg" = ["org.telegram.desktop.desktop "];

        "audio/*" = ["mpv.desktop"];
        "video/*" = ["mpv.dekstop"];
        "image/*" = ["imv.desktop"];
        "image/gif" = ["imv.desktop"];
        "image/jpeg" = ["imv.desktop"];
        "image/png" = ["imv.desktop"];
        "image/webp" = ["imv.desktop"];
      };

      associations.removed = {
        # ......
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
  home = {
    sessionVariables = {
      XDG_CACHE_HOME = lib.mkForce "$HOME/.cache";
      XDG_CONFIG_HOME = lib.mkForce "$HOME/.config";
      XDG_DATA_HOME = lib.mkForce "$HOME/.local/share";
      XDG_STATE_HOME = lib.mkForce "$HOME/.local/state";
      XDG_BIN_HOME = lib.mkForce "$HOME/.local/bin"; # Not technically in the official xdg specification
      XDG_DESKTOP_DIR = lib.mkForce "$HOME/Desktop";
      XDG_DOWNLOAD_DIR = lib.mkForce "$HOME/Downloads";
      # AJLOW_OCAML_TOOLS = "dune merlin ocaml-lsp-server odoc ocamlformat utop
      # dune-release core core_unix base";
    };
    sessionPath = [
      "$XDG_BIN_HOME"
    ];
  };
}
