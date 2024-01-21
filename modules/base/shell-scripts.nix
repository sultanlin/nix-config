{
  config,
  pkgs,
  nixosPath,
  ...
}: let
  # shellPath = script: ../../scripts/${script};
in {
  environment.systemPackages = [
    (import /. + builtins.toPath "${nixosPath}/scripts/direnv-create.nix" {inherit pkgs;})
    (import /. + builtins.toPath "${nixosPath}/scripts/direnv-add.nix" {inherit pkgs;})
    # (import ../../shell/direnv-add.nix {inherit pkgs;})
  ];
}
