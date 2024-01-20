{
  config,
  pkgs,
  ...
}: 
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";

    # extraConfig =  builtins.readFile ./tmux.conf;
    # keyMode = "vi";  # default is emacs

    baseIndex = 1; # start index from 1
    escapeTime = 0; # do not wait for escape key
    terminal = "xterm-256color";
  };
}
