{
  pkgs,
  # pkgs-unstable,
  catppuccin-yazi,
  ...
}: {
  # terminal file manager
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    # Changing working directory when exiting Yazi
    enableBashIntegration = true;
    # TODO: nushellIntegration is broken on release-23.11, wait for master's fix to be released
    enableNushellIntegration = false;
  };

  xdg.configFile."yazi/theme.toml".source = "${catppuccin-yazi}/mocha.toml";
}
