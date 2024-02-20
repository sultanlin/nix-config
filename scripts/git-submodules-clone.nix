{
  pkgs,
  nixosPath,
  ...
}:
pkgs.writeShellScriptBin "dva" ''
  # echo "use flake $HOME/nix-config/programming/$1" >> .envrc
  git submodule update --init --remote --recursive
''
