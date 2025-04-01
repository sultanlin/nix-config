{catppuccin-bat, ...}: {
  # a cat(1) clone with syntax highlighting and Git integration.
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Catppuccin-mocha";
    };
    themes = {
      # https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme
      # Catppuccin-mocha = builtins.readFile "${catppuccin-bat}/themes/Catppuccin Mocha.tmTheme";
      # https://www.reddit.com/r/NixOS/comments/1g1xsyk/any_one_knows_how_to_set_up_catppuccinbat_in_nixos/
      Catppuccin-mocha = {
        src = catppuccin-bat;
        file = "extras/Catppuccin\ Mocha.tmTheme";
      };
    };
  };
}
