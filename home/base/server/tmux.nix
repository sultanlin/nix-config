{
  config,
  dotfilesConfigPath,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";

    # extraConfig = builtins.readFile dotfilesConfigPath + /tmux/tmux.conf;
    extraConfig = ''
            set-option -g terminal-overrides ',xterm-256color:RGB'
            # set -g @sessionx-bind 'o'
      # set -g @sessionx-x-path '~/dotfiles'
      # set -g @sessionx-window-height '85%'
      # set -g @sessionx-window-width '75%'
      # set -g @sessionx-zoxide-mode 'on'
      # set -g @sessionx-filter-current 'false'
      # set -g @sessionx-preview-enabled 'true'
      # set -g @continuum-restore 'on'
      # set -g @resurrect-strategy-nvim 'session'
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
      # set -g @catppuccin_directory_text "#{b:pane_current_path}"
      # set -g @catppuccin_meetings_text "#($HOME/.config/tmux/scripts/cal.sh)"
      set -g @catppuccin_date_time_text "%H:%M"
    '';
    keyMode = "vi"; # default is emacs

    baseIndex = 1; # start index from 1
    escapeTime = 0; # do not wait for escape key
    # terminal = "xterm-256color";
    terminal = "screen-254color";
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
