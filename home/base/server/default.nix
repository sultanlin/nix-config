{
  mylib,
  dotfilesConfig,
  config,
  ...
}: let
  config_sym_dir = config.lib.file.mkOutOfStoreSymlink "${dotfilesConfig}";
in {
  imports = mylib.scanPaths ./.;

  # xdg.configFile."hypr" = {
  #   # source = "${config_sym_dir}/hypr";
  #   source = builtins.toPath "${dotfilesConfig}/hypr";
  #   recursive = true;
  # };
  home.file = {
    ".config/nvim" = {
      #source = config.lib.file.mkOutOfStoreSymlink "${dotfilesConfig}/nvim";
      # source = config.lib.file.mkOutOfStoreSymlink "${dotfilesConfig}/nvim-nixos";
      # source = "${config_sym_dir}/nvim-nixos";
      source = "${config_sym_dir}/nvim";
      # source = mylib.symlinkConfig "/nvim-nixos";
      recursive = true;
      # target = ".config/nvim";
    };
    #file.".config/tmux" = {
    # source = "${config_sym_dir}/tmux";
    #  recursive = true;
    #};
    # ".config/tmux" = {
    #   source = "${config_sym_dir}/tmux";
    #   recursive = true;
    # };
    ".config/hypr" = {
      source = "${config_sym_dir}/hypr";
      # source = "${dotfilesConfig}/hypr";
      # source = builtins.toPath "${dotfilesConfig}/hypr";
      # source = mylib.symlinkConfig "/hypr";
      recursive = true;
    };
    # ".config/zsh/.p10k.zsh" = {
    #   source = "${config_sym_dir}/zsh/.p10k.zsh";
    #   # source = "${dotfilesConfig}/hypr";
    #   # source = builtins.toPath "${dotfilesConfig}/hypr";
    #   # source = mylib.symlinkConfig "/hypr";
    #   recursive = true;
    # };
    # nvim = {
    #   # source = "${config_sym_dir}/hypr";
    #   source = "${dotfilesConfig}/hypr";
    #   # source = builtins.toPath "${dotfilesConfig}/hypr";
    #   # source = mylib.symlinkConfig "/hypr";
    #   recursive = true;
    #   target = ".config/hypr";
    # };
  };
  # home.sessionVariables = {
  #   dotfiles = "dotfilesConfig";
  #     # XDG_CACHE_HOME = lib.mkForce "$HOME/.cache";
  #     # XDG_CONFIG_HOME = lib.mkForce "$HOME/.config";
  #     # XDG_DATA_HOME = lib.mkForce "$HOME/.local/share";
  #     # XDG_STATE_HOME = lib.mkForce "$HOME/.local/state";
  #     # XDG_BIN_HOME = lib.mkForce "$HOME/.local/bin"; # Not technically in the official xdg specification
  #     # XDG_DESKTOP_DIR = lib.mkForce "$HOME/Desktop";
  #     # XDG_DOWNLOAD_DIR = lib.mkForce "$HOME/Downloads";
  #     # AJLOW_OCAML_TOOLS = "dune merlin ocaml-lsp-server odoc ocamlformat utop
  #     # dune-release core core_unix base";
  #   };
  #   sessionPath = [
  #     "$XDG_BIN_HOME"
  #   ];
  # };
}
