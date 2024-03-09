{
  username,
  config,
  pkgs,
  ...
}: let
  d = config.xdg.dataHome;
  c = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    inherit username;
    # homeDirectory = "/home/${username}";

    sessionVariables = {
      # clean up ~
      LESSHISTFILE = cache + "/less/history";
      LESSKEY = c + "/less/lesskey";
      WINEPREFIX = d + "/wine";

      # set this variable make i3 failed to start
      # related issue:
      #   https://github.com/sddm/sddm/issues/871
      # XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

      # set default applications
      BROWSER = "firefox";

      # enable scrolling in git diff
      DELTA_PAGER = "less -R";
    };
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
  };

  # # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Add derivation
  home.packages = [
    import
    ./pkgs
    {inherit pkgs;}
  ];
}
