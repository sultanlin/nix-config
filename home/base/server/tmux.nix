{
  config,
  dotfilesConfigPath,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    # shell = "${pkgs.zsh}/bin/zsh";

    # extraConfig = builtins.readFile dotfilesConfigPath + /tmux/tmux.conf;
    extraConfig = ''source-file ~/.config/tmux/extras/tmux.conf'';
    keyMode = "vi"; # default is emacs

    baseIndex = 1; # start index from 1
    escapeTime = 0; # do not wait for escape key
    # terminal = "xterm-256color";
    # terminal = "screen-254color";
    terminal = "screen-256color";
    mouse = true;

    prefix = "C-a";
    shortcut = "a";

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      gruvbox
      catppuccin
      # {
      #   plugin = catppuccin;
      #   extraConfig = ''
      #     set -g @catppuccin_flavor 'mocha'
      #   '';
      # }
      battery
    ];
  };
}
