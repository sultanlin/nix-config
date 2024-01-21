{
  config,
  pkgs,
  nixosPath,
  ...
}: let
  shellPath = script: (import ../../scripts/${script} {inherit pkgs;});
in {
  environment.systemPackages = [
    shellPath
    ./direnv-create.nix
    shellPath
    ./direnv-add.nix
    # (import shellPath ./direnv-create.nix {inherit pkgs;})
    # (import shellPath ./direnv-add.nix {inherit pkgs;})
    # (import /. + builtins.toPath "${nixosPath}/scripts/direnv-create.nix" {inherit pkgs;})
    # (import /. + builtins.toPath "${nixosPath}/scripts/direnv-add.nix" {inherit pkgs;})
    # (import ../../shell/direnv-add.nix {inherit pkgs;})
  ];
}
