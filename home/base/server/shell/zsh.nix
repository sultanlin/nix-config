{ pkgs, username, ... }:

{
  # home.users.${username}.shell = pkgs.zsh;

  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      #histSize = 100000;
      # Automatically goes into directory without cd
      autocd = true;

      history = {
	        ignoreAllDups = true;
		      extended = true;
		      expireDuplicatesFirst = true;
	    };

      dirHashes = {
        docs = "$(xdg-user-dir DOCUMENTS)";
        dl = "$(xdg-user-dir DOWNLOAD)";
        pics = "$(xdg-user-dir PICTURES)";
        vids = "$(xdg-user-dir VIDEOS)";
      };

      dotDir = ".config/zsh";

      #shellInit = ''
      #  # Spaceship
      #  source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
      #  autoload -U promptinit; promptinit
      #  # Hook direnv
      #  #emulate zsh -c "$(direnv hook zsh)"

      #  #eval "$(direnv hook zsh)"
      #'';                                       # Theming

      initExtra = ''
        # zsh vi mode install
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

        # # zsh autopair
        source ${pkgs.zsh-autopair}/share/zsh-autopair/autopair.zsh
        # source ~/.zsh-autopair/autopair.zsh
        autopair-init
      '';

      completionInit = ''
        # Basic auto/tab complete:
        autoload -U compinit
        zstyle ':completion:*' menu select
        zmodload zsh/complist
        compinit
        _comp_options+=(globdots)		# Include hidden files.
      '';  
    };

    home.packages = with pkgs; [
      zsh
      nix-zsh-completions
      bat
      fasd
      fd
      fzf
      jq
      ripgrep
      tldr
    ];

    env = {
      ZDOTDIR   = "$XDG_CONFIG_HOME/zsh";
      ZSH_CACHE = "$XDG_CACHE_HOME/zsh";
      ZGEN_DIR  = "$XDG_DATA_HOME/zgenom";
    };
  };
}
