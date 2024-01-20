{
  config,
  lib,
  pkgs,

  userfullname,
  useremail,
  ...
}: {
  programs.eza = {
    enable = true;
    icons = true;
    git = true;
    
    enableAliases = true;

    # extraOptions = {}
  };
}
