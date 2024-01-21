{
  pkgs,
  nixosPath,
  ...
}:
pkgs.writeShellScriptBin "dva" ''
  # echo "use flake $HOME/nix-config/programming/$1" >> .envrc
  echo "use flake ${nixosPath}/programming/$1" >> .envrc
  direnv allow
''
