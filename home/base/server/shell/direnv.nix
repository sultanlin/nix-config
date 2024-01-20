{
  config,
  lib,
  pkgs,
  ...
}: {
    # Easy shell environments
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;

    # stdlib = ''
    #   use_riff() {
    #     watch_file Cargo.toml Cargo.lock
    #     eval "$(riff print-dev-env)"
    #   }
    # '';
  };
}
