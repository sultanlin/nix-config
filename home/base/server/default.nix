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
    ".config/tmux/extras" = {
      # Best solution to utilize both nixos config and symlinked config
      # Nixos tmux config has extraConfig that sources tmux.conf from .config/tmux/extras
      source = "${config_sym_dir}/tmux";
      recursive = true;
    };
    ".config/hypr" = {
      source = "${config_sym_dir}/hypr";
      recursive = true;
    };
    ".config/fastfetch" = {
      source = "${config_sym_dir}/fastfetch";
      recursive = true;
    };
    ".config/swappy" = {
      source = "${config_sym_dir}/swappy";
      recursive = true;
    };
  };
  home.sessionVariables = {
    DOTFILES_CONFIG = "${dotfilesConfig}";
  };
}
