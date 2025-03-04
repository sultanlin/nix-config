{
  pkgs,
  lib,
  dotfilesConfig,
  config,
  nixosPath,
  ...
}: {
  programs = {
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      # enableAutosuggestions = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      #histSize = 100000;
      # histSize = 10000;
      # Automatically goes into directory without cd
      autocd = true;
      defaultKeymap = "emacs";

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

      shellAliases = lib.mkForce {
        #   ne = "nix-env";
        #   ni = "nix-env -iA";
        #   no = "nixops";
        #   ns = "nix-shell --pure";
        #   please = "sudo";
        ls = "eza --icons  -T -L 1 -x";
        ll = "eza --icons  -T -L 2 -x";
        cp = "cp -iv";
        flake-rebuild = "sudo nixos-rebuild switch --flake ${nixosPath}";
        flake-test = "sudo nixos-rebuild test --flake ${nixosPath}";
        flake-update = "sudo nix flake update ${nixosPath}";
      };

      initExtra = ''
        # # zsh vi mode install
        # source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

        # # zsh autopair
        # source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh
        # autopair-init

        # powerlevel10k
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        # test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh
        test -f ${dotfilesConfig}/zsh/.p10k.zsh && source ${dotfilesConfig}/zsh/.p10k.zsh

        # Up arrow grep searching (for example, type zsh and press up)
        source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh

        zmodload zsh/terminfo
        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down
        bindkey '^[[A' history-substring-search-up
        bindkey '^[OA' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
        bindkey '^[OB' history-substring-search-down
        bindkey -M vicmd '^[[A' history-substring-search-up
        bindkey -M vicmd '^[OA' history-substring-search-up
        bindkey -M vicmd '^[[B' history-substring-search-down
        bindkey -M vicmd '^[OB' history-substring-search-down
        bindkey -M viins '^[[A' history-substring-search-up
        bindkey -M viins '^[OA' history-substring-search-up
        bindkey -M viins '^[[B' history-substring-search-down
        bindkey -M viins '^[OB' history-substring-search-down

        #this is a test
        # Remind you of aliases
        source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh
      '';

      completionInit = ''
        # colours
        autoload -U colors && colors	      # colours
        autoload -U compinit && compinit    # basic completion
        autoload -U compinit colors zcalc   # theming

        # tab completion
        zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
        zstyle ':completion:*' list-colors "''${(s.:.)--color=auto}"                        # Colored completion (different colors for dirs/files/etc)
        zstyle ':completion:*' rehash true                                                # automatically find new executables in path
        zstyle ':completion:*' menu select                                                # Highlight menu selection
        zstyle ':completion:*' ignored-patterns '*.lock'

        # completion
        zstyle :compinstall ~/.config/zsh/.zshrc

        #
        # Basic auto/tab complete:
        autoload -U compinit
        zmodload zsh/complist
        compinit
        _comp_options+=(globdots)		# Include hidden files.

        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word


        # Docker autocomplete fix
        zstyle ':completion:*:*:docker:*' option-stacking yes
        zstyle ':completion:*:*:docker-*:*' option-stacking yes

        # https://unix.stackexchange.com/questions/33255/how-to-define-and-load-your-own-shell-function-in-zsh
        fpath=($HOME/nix-config/dotfiles/config/zsh $fpath)
        autoload -U $HOME/nix-config/dotfiles/config/zsh/_docker
        #
        #   # Delete 1 level in a path using ESC+DEL
        #   function kill-path-word()
        #   {
        #     local words word spaces
        #       zle set-mark-command                 # save current cursor position ("mark")
        #       while [[ $LBUFFER[-1] == "/" ]] {
        #         (( CURSOR -= 1 ))                  # consume all trailing slashes
        #       }
        #     words=("''${(s:/:)LBUFFER/\~/_}")       # split command line at "/" after "~" is replaced by "_" to prevent FILENAME EXPANSION messing things up
        #       word=$words[-1]                       # this is the portion from cursor back to previous "/"
        #       (( CURSOR -= $#word ))                # then, jump to the previous "/"
        #       zle exchange-point-and-mark           # swap "mark" and "cursor"
        #       zle kill-region                       # delete marked region
        #   }
        #   zle -N kill-path-word
        #   bindkey "^[^[[3~" kill-path-word
        # '';
    };
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
}
