{
  pkgs,
  nixosPath,
  ...
}:
pkgs.writeShellScriptBin "mygitsubmodule" ''
  # Initially get submodules
  # git submodule update --init --remote --recursive

  # Update submodules (do not use git pull --recursive)
  # git submodule update --remote --recursive --merge
''
