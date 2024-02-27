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
    extraConfig = ''
      # source-file ~/.config/tmux/extras/tmux.conf
      set -g status-position top       # macOS / darwin style
      bind R source-file ~/.config/tmux/tmux.conf

      set-option -g terminal-overrides ',xterm-256color:RGB'
      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
      set -g @catppuccin_status_modules_right "directory meetings date_time"
      set -g @catppuccin_status_modules_left "session"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator " "
      set -g @catppuccin_status_right_separator_inverse "no"
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"
      set -g @catppuccin_directory_text "#{b:pane_current_path}"
      set -g @catppuccin_meetings_text "#($HOME/.config/tmux/scripts/cal.sh)"
      set -g @catppuccin_date_time_text "%H:%M"
    '';
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
      # gruvbox
      # catppuccin
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
        '';
      }
      battery
    ];
  };
}
