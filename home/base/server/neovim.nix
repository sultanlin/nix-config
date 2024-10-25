{
  pkgs,
  pkgs-stable,
  ...
}: {
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
      # enable = false;
      defaultEditor = true;

      # Nightly failing, tree-sitter old version
      # package = pkgs.neovim-nightly.overrideAttrs (_: {CFLAGS = "-O3";});
      # package = pkgs.neovim-nightly;

      viAlias = true;
      vimAlias = true;

      withPython3 = true;
      withNodeJs = true;

      plugins = let
        nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (treesitter-plugins:
          with treesitter-plugins; [
            c
            vim
            vimdoc
            query
            angular
            bash
            c
            cpp
            css
            dockerfile
            git_rebase
            gitcommit
            go
            html
            hyprlang
            java
            javascript
            json
            kotlin
            llvm
            lua
            luadoc
            markdown
            markdown_inline
            nix
            python
            rust
            sql
            svelte
            templ
            terraform
            tmux
            tsx
            typescript
            vue
            yaml
          ]);
      in
        with pkgs.vimPlugins; [
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
          rose-pine

          #-- TREESITTER
          nvim-treesitter.withAllGrammars # Highlight, edit, and navigate code
          # nvim-treesitter-with-plugins
          nvim-treesitter-textobjects
          nvim-ts-context-commentstring
          rainbow-delimiters-nvim
          playground
          # Doesn't work
          # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/tools/parsing/tree-sitter/grammars/tree-sitter-just.json
          # (nvim-treesitter.withPlugins (_:
          #   nvim-treesitter.allGrammars
          #   ++ [
          #     (pkgs.tree-sitter.buildGrammar {
          #       language = "just";
          #       version = "f807ab3";
          #       src = pkgs.fetchFromGitHub {
          #         owner = "IndianBoy42";
          #         repo = "tree-sitter-just";
          #         rev = "f807ab33c36651ecb503a291aed933932754864d";
          #         sha256 = "sha256-iK+MpyK5pQ/sYT2CHYmeI0k231HwHdZ80ij1cqlO5Nk=";
          #       };
          #     })
          #   ]))

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
          cmp-emoji
          cmp-tabnine

          #-- LSP - Formatting - Linting - Debugging
          nvim-lspconfig # LSP configuration
          neodev-nvim # Additional lua config
          conform-nvim # Formatter
          nvim-lint
          none-ls-nvim # Lint and format and code actions
          nvim-bqf
          trouble-nvim
          nvim-dap
          nvim-dap-ui
          nvim-dap-virtual-text
          telescope-dap-nvim
          nvim-dap-go
          nvim-dap-python
          nvim-jdtls # Java
          spring-boot-java
          mason-nvim
          rustaceanvim # Rust
          crates-nvim # Rust crates
          typescript-tools-nvim

          #-- Code testing
          neotest
          # General tests
          vim-test
          neotest-vim-test
          # Language specific tests
          neotest-vitest # JS? TS?
          neotest-python
          neotest-plenary
          neotest-rust
          # neotest-bash
          neotest-deno
          neotest-dotnet # C#
          neotest-go
          neotest-jest # Javacript
          neotest-java
          # neotest-zig
          # neotest-dart
          # neotest-elixir
          # neotest-haskell
          # neotest-pest    # PhP
          # neotest-phpunit
          # neotest-scala
          # neotest-rspec   # ruby
          # neotest-testthat    # R

          #-- Git
          vim-fugitive # Let's you do git commands using :G instead of :!g in vim cmd
          gitsigns-nvim # Shows changes to git in the left margin
          gitlinker-nvim # Link to github and blame and ??????
          lazygit-nvim # UI terminal for git commands
          vim-rhubarb # "If fugitive is the git, rhubarb is the hub"
          neogit # Emacs' magit in neovim
          diffview-nvim

          #-- Navigation
          alpha-nvim
          project-nvim
          nvim-tree-lua # Potentially remove, mainly use oil.nvim
          oil-nvim
          toggleterm-nvim
          telescope-nvim # Fuzzy finder (files, lsp, etc)
          telescope-fzf-native-nvim
          vim-tmux-navigator
          harpoon
          grapple-nvim

          #-- UI
          lualine-nvim # DONE
          barbecue-nvim
          nvim-navic
          tabby-nvim
          dressing-nvim
          nvim-web-devicons
          indent-blankline-nvim # DONE
          modicator-nvim
          nvim-colorizer-lua
          todo-comments-nvim
          zen-mode-nvim
          twilight-nvim
          vim-matchup
          vim-illuminate

          #-- Nice to have
          comment-nvim
          SchemaStore-nvim
          eyeliner-nvim
          which-key-nvim
          legendary-nvim

          #-- Utils
          # numb-nvim
          nvim-spider
          tabout-nvim # Potentially remove later if you're used to living without autopairs
          nvim-surround
          neorg
          undotree
          nvim-ufo
          promise-async
          statuscol-nvim
          nvim-spectre
          vim-sleuth
          markdown-preview-nvim
          glow-nvim
          mini-nvim

          lazy-lsp-nvim

          #-- CORE
          plenary-nvim

          #-- Future plugins
          # flash-nvim
          # fzf-lua
          # lsp_signature-nvim

          #-- Unwanted plugins
          # hardtime-nvim # No longer need it (helps learn nvim by blocking bad practice)
          # barbar-nvim     # Adds buffer as tab, don't want that
          # neoscroll-nvim    # BLOAT
          # nvim-navbuddy       # BLOAT
          # auto-session      # Not needed
          refactoring-nvim # Too difficult, code actions like move code to separate function etc
          nvim-autopairs # Learn to live without it
          # nvim-ts-autotag # Learn to live without it
          noice-nvim # BLOAT
          # vim-jsx-pretty # Don't think I need it
          # sentiment-nvim # Replaced by vim-matchup
          # fidget-nvim # BUGGY Useful notifications and status updates for LSP
          nui-nvim

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

      extraPackages = with pkgs; [
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
    nodePackages.live-server

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
    luajitPackages.luacheck

    #-- Rust
    rust-analyzer
    cargo # rust package manager
    # rustfmt
    graphviz
    vscode-extensions.vadimcn.vscode-lldb

    #-- Nix
    statix # Lints and suggestions for the nix programming language
    deadnix # Find and remove unused code in .nix source files
    alejandra # Nix Code Formatter
    nil
    # rnix-lsp
    nixpkgs-fmt
    nixd
    nixfmt-rfc-style

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
    rustywind
    nodePackages.fixjson
    # SVELTE LSP
    nodePackages.svelte-language-server
    # Graphql LSP
    nodePackages.graphql-language-service-cli
    # Prisma LSP
    nodePackages.prisma

    #-- Go
    go
    gomodifytags
    # iferr # generate error handling code for go
    impl # generate function implementation for go   # UNUSED
    gotools # contains tools like: godoc, goimports, etc.
    gopls # go language server
    delve # go debugger
    golangci-lint
    air # Live reloading for server hosting
    templ # Templ HTML in go

    #-- Java
    jdt-language-server
    # jdtls
    google-java-format
    lombok
    vscode-extensions.vscjava.vscode-java-test
    vscode-extensions.vscjava.vscode-java-debug

    #-- Kotlin
    kotlin-language-server
    ktlint

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

    lazygit

    #-- Optional Requirements:
    gdu # disk usage analyzer, required by AstroNvim
    ripgrep # fast search tool, required by AstroNvim's '<leader>fw'(<leader> is space key)
    verible
    fd
  ];

  home.sessionVariables = {
    # source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

    # OMNISHARP_ROSLYN_PATH = "${pkgs.omnisharp-roslyn}";
    LSP_OMNISHARP = "${pkgs.omnisharp-roslyn}";
    LSP_JAVA = "${pkgs.jdt-language-server}";
    # LSP_JAVA_MINE = "${pkgs.jdtls}";
    LSP_LOMBOK = "${pkgs.lombok}";
    LSP_JAVA_TEST = "${pkgs.vscode-extensions.vscjava.vscode-java-test}";
    LSP_JAVA_DEBUG = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}";
    LSP_CODELLDB = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}";
    # vscode-extensions.vadimcn.vscode-lldb

    NEOVIM_NIXOS = "true";
  };
}
