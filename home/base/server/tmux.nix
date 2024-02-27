{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    # sensibleOnTop = false;
    # terminal = "";
    # shell = "${pkgs.zsh}/bin/zsh";

    # extraConfig =  builtins.readFile ./tmux.conf;
    # keyMode = "vi";  # default is emacs

    # baseIndex = 1; # start index from 1
    # escapeTime = 0; # do not wait for escape key
    # terminal = "xterm-256color";

    # plugins = with pkgs.tmuxPlugins; [
    #   vim-tmux-navigator
    #   # gruvbox
    #   # catppuccin
    #   {
    #     plugin = catppuccin;
    #     extraConfig = ''
    #       set -g @catppuccin_flavor 'mocha'
    #     '';
    #   }
    #   battery
    # ];
  };
}
