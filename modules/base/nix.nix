{
  lib,
  # nixpkgs,
  inputs,
  nixpkgs-unstable,
  ...
}: {
  # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
  # nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.registry.nixpkgs.flake = nixpkgs-unstable;
  nix.channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.

  # but NIX_PATH is still used by many useful tools, so we set it to the same value as the one used by this flake.
  # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  # environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs-unstable}";
  # https://github.com/NixOS/nix/issues/9574
  nix.settings.nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
}
