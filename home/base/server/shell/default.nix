{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./btop.nix
    ./git.nix
    ./starship.nix
    # ./tmux.nix
    ./zsh.nix
    ./direnv.nix
  ];

  home.packages = with pkgs; [
  ];
}
