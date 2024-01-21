{
  config,
  pkgs,
  nixosPath,
  ...
}: {
  environment.systemPackages = [
    (import builtins.toPath "${nixosPath}shell/direnv-create.nix" {inherit pkgs;})
    (import builtins.toPath "${nixosPath}shell/direnv-add.nix" {inherit pkgs;})
    # (import ../../shell/direnv-add.nix {inherit pkgs;})
  ];
}
