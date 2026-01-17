{
  pkgs,
  pkgs-stable,
  ...
}: {
  # WARNING: Remove this while using useGlobalPkgs
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
    neovim = {
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

      # plugins = with pkgs.vimPlugins; [];
      # extraPackages = with pkgs; [];
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
    # nodePackages.live-server # TODO: removed: unmaintained

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
    # nodePackages.pyright
    pyright
    # ruff-lsp
    ruff

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
    # nodePackages.typescript-language-server
    typescript-go
    eslint_d
    # HTML/CSS/JSON/ESLint language servers extracted from vscode
    nodePackages.vscode-langservers-extracted
    nodePackages."@tailwindcss/language-server"
    emmet-ls
    rustywind
    nodePackages.fixjson
    # SVELTE LSP
    nodePackages.svelte-language-server
    # Graphql LSP
    nodePackages.graphql-language-service-cli
    # Prisma LSP
    nodePackages.prisma
    angular-language-server
    vue-language-server

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
    dockerfile-language-server
    # terraform  # install via brew on macOS
    terraform-ls
    jsonnet
    jsonnet-language-server
    hadolint # Dockerfile linter

    # Additional
    nodePackages.markdownlint-cli
    markdownlint-cli2
    # markdown-toc # TODO: Uncomment after update
    codespell
    gitlint
    taplo # TOML language server / formatter / validator
    # taplo-cli
    nodePackages.yaml-language-server
    # sqlfluff # SQL linter
    actionlint # GitHub Actions linter
    buf # protoc plugin for linting and formatting
    proselint # English prose linter
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

    #-- Treesitter
    tree-sitter # common language parser/highlighter
    gcc # c/c++ compiler, required by nvim-treesitter!
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

    NEOVIM_NIXOS = "true";
  };
}
