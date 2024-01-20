{pkgs, ...}: {
  nixpkgs.config = {
    programs.npm = {
      enable = true;
      npmrc = ''
        prefix = ''${HOME}/.npm-global
        color = true
      '';
    };
  };

  #home.sessionVariables = {
  #  EDITOR = "${config.home.profileDirectory}/bin/nvim";
  #};

  programs = {
    neovim = let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in {
      enable = true;
      defaultEditor = true;

      # Nightly maybe?
      # package = pkgs.neovim-nightly.overrideAttrs (_: { CFLAGS = "-O3"; });
      # package = inputs.neovim-nightly.packages."${pkgs.system}".default.override(old: old // { inherit (pkgs) libvterm-neovim; });

      viAlias = true;
      vimAlias = true;

      withPython3 = true;
      withNodeJs = true;
      extraPackages = with pkgs; [];

      plugins = with pkgs.vimPlugins; [
        # Non-neovim plugins (aka vim plugins) don't need a .setup() in config

        #-- COLORSCHEMES
        gruvbox-nvim
        gruvbox-material
        tokyonight-nvim
        oceanic-next
        catppuccin-nvim
        nightfox-nvim
        onehalf
        kanagawa-nvim
        onedark-nvim
        #onedarkpro-nvim
        nord-nvim
        onenord-nvim
        neovim-ayu
        papercolor-theme
        iceberg-vim
        nightfly
        sonokai
        everforest
        monokai-pro-nvim
        # bamboo-nvim not yet available
        papercolor-theme
        oxocarbon-nvim

        #-- TREESITTER
        nvim-treesitter.withAllGrammars # Highlight, edit, and navigate code
        nvim-treesitter-textobjects
        nvim-ts-context-commentstring
        nvim-ts-autotag
        nvim-ts-rainbow

        #-- TELESCOPE
        telescope-nvim # Fuzzy finder (files, lsp, etc)
        telescope-fzf-native-nvim

        #-- COMPLETION
        nvim-cmp
        luasnip
        cmp-path
        cmp-buffer
        cmp-nvim-lsp
        cmp_luasnip
        cmp-cmdline
        friendly-snippets
        lspkind-nvim
        cmp-nvim-lua

        #-- LSP - Formatting - Linting
        nvim-lspconfig # LSP configuration
        # mason-nvim
        # mason-lspconfig-nvim
        # mason-tool-installer-nvim
        # null-ls-nvim
        neodev-nvim # Additional lua config
        conform-nvim # Formatter
        nvim-lint
        none-ls-nvim

        nvim-autopairs
        which-key-nvim
        comment-nvim
        gitsigns-nvim
        # Github plugins
        vim-fugitive
        vim-rhubarb
        fidget-nvim # Useful status updates for LSP
        own-sentiment-nvim

        #  {
        # error: Failed assertions:
        # - sultan profile: `nixpkgs` options are disabled when `home-manager.useGlobalPkgs` is enabled.
        #    plugin = vimPlugins.sentiment-nvim;
        #  }

        nvim-surround
        indent-blankline-nvim # DONE
        lualine-nvim # DONE
        refactoring-nvim
        nvim-autopairs
        # guess-indent-nvim
        vim-sleuth

        hardtime-nvim
        nui-nvim

        #-- Future plugins
        # eyeliner-nvim
        # flash-nvim
        # fzf-lua

        #-- CORE
        plenary-nvim
        nvim-web-devicons
        dressing-nvim

        # This does not work, unsure why
        # Maybe because I'm using outofstoresymlink.
        # TLDR the config is supposed to be added to init.lua
        # Maybe I'm doing something that conflicts with that
        #{
        #  plugin = gitsigns-nvim;
        #  type = "lua";
        #  config = ''
        #    require("gitsigns").setup()
        #  '';
        #}
      ];
    };
  };
  home.packages = with pkgs; [
    #-- c/c++
    cmake
    cmake-language-server
    gnumake
    checkmake
    gcc # c/c++ compiler, required by nvim-treesitter!
    clang-tools
    cppcheck
    gdb

    # https://github.com/LongerHV/nixos-configuration/blob/48c8052cb47c8d83f14adbd5c2c142ebef142dd3/home-manager/config/neovim.nix#L246

    #-- Essentials
    nodePackages.npm
    nodePackages.neovim

    #-- Python
    (python3.withPackages (ps:
      with ps; [
        setuptools # Required by pylama for some reason
        pylama
        black
        isort
        yamllint
        debugpy
        # ruff-lsp
      ]))
    nodePackages.pyright
    ruff-lsp

    #-- Lua
    lua-language-server
    selene
    stylua

    #-- Rust
    rust-analyzer
    cargo # rust package manager
    rustfmt

    #-- Nix
    statix # Lints and suggestions for the nix programming language
    deadnix # Find and remove unused code in .nix source files
    alejandra # Nix Code Formatter
    nil
    rnix-lsp
    nixpkgs-fmt
    nixd

    #-- Bash/Shell scripting
    nodePackages.bash-language-server
    shfmt
    shellcheck
    shellharden

    #-- Javascript/Typescript --#
    nodePackages.prettier
    nodePackages.eslint
    nodePackages.typescript
    nodePackages.typescript-language-server
    eslint_d
    # HTML/CSS/JSON/ESLint language servers extracted from vscode
    nodePackages.vscode-langservers-extracted
    nodePackages."@tailwindcss/language-server"
    emmet-ls
    prettierd

    #-- Go
    go
    gomodifytags
    iferr # generate error handling code for go
    impl # generate function implementation for go
    gotools # contains tools like: godoc, goimports, etc.
    gopls # go language server
    delve # go debugger
    golangci-lint
    air # Live reloading for server hosting

    #-- C#
    omnisharp-roslyn
    netcoredbg # C# Debugger

    #-- CloudNative
    nodePackages.dockerfile-language-server-nodejs
    # terraform  # install via brew on macOS
    terraform-ls
    jsonnet
    jsonnet-language-server
    hadolint # Dockerfile linter

    # Additional
    nodePackages.markdownlint-cli
    vale
    codespell
    gitlint
    taplo # TOML language server / formatter / validator
    taplo-cli
    nodePackages.yaml-language-server
    sqlfluff # SQL linter
    actionlint # GitHub Actions linter
    buf # protoc plugin for linting and formatting
    proselint # English prose linter
    tree-sitter # common language parser/highlighter
    marksman # language server for markdown
    glow # markdown previewer
    fzf

    # Clipboard
    xclip
    wl-clipboard

    #-- Optional Requirements:
    gdu # disk usage analyzer, required by AstroNvim
    ripgrep # fast search tool, required by AstroNvim's '<leader>fw'(<leader> is space key)
    verible
    fd
  ];

  home.sessionVariables = {
    # source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

    OMNISHARP_ROSLYN_PATH = "${pkgs.omnisharp-roslyn}";
  };
}
