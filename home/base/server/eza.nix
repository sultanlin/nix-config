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
    # icons = true;
    icons = "auto";
    git = true;

    # enableAliases = true;

    # extraOptions = {}
  };
}
