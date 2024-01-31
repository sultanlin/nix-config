{
  catppuccin-starship,
  dotfilesConfigPath,
  dotfilesConfig,
  config,
  ...
}: {
  programs.starship = {
    enable = false;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;

    enableTransience = true;

    # settings =
    #   {
    #     character = {
    #       success_symbol = "[›](bold green)";
    #       error_symbol = "[›](bold red)";
    #     };
    #     aws = {
    #       symbol = "🅰 ";
    #     };
    #     gcloud = {
    #       # do not show the account/project's info
    #       # to avoid the leak of sensitive information when sharing the terminal
    #       format = "on [$symbol$active(\($region\))]($style) ";
    #       symbol = "🅶 ️";
    #     };
    #
    #     palette = "catppuccin_mocha";
    #
    #     add_newline = false;
    #     line_break.disabled = true;
    #   }
    #   // builtins.fromTOML (builtins.readFile "${dotfilesConfigPath}/starship/starship.toml")
    #   // builtins.fromTOML (builtins.readFile "${catppuccin-starship}/palettes/mocha.toml");
  };

  # home.file.".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesConfig}/starship/starship.toml";
}
