
{ pkgs, ... }:
  pkgs.writeShellScriptBin "dva" ''
    echo "use flake $HOME/nixos-config/home/programming/$1" >> .envrc
    direnv allow
  ''
