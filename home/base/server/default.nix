{
  mylib,
  dotfilesConfig,
  config,
  ...
}: let
  config_sym_dir = config.lib.file.mkOutOfStoreSymlink "${dotfilesConfig}";
in {
  imports = mylib.scanPaths ./.;

  home = {
    file.".config/nvim" = {
      #source = config.lib.file.mkOutOfStoreSymlink "${dotfilesConfig}/nvim";
      # source = config.lib.file.mkOutOfStoreSymlink "${dotfilesConfig}/nvim-nixos";
      source = "${config_sym_dir}/nvim-nixos";
      # source = mylib.symlinkConfig "/nvim-nixos";
      recursive = true;
      # target = ".config/nvim";
    };
    xdg.configFile."hypr" = {
      source = "${config_sym_dir}/hypr";
      recursive = true;
    };
    #file.".config/tmux" = {
    # source = "${config_sym_dir}/tmux";
    #  recursive = true;
    #};
    # file.".config/hypr" = {
    #   source = "${config_sym_dir}/hypr";
    #   # source = "${dotfilesConfig}/hypr";
    #   # source = mylib.symlinkConfig "/hypr";
    #   recursive = true;
    # };
  };
}
