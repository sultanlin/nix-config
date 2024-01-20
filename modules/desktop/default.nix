{mylib, ...}: {
  imports = mylib.scanPaths ./.;
}
# {
#   imports = [
#     ./fonts.nix
#     ./graphic.nix
#     ./misc.nix
#     ./peripherals.nix
#     ./security.nix
#     # ./visualisation.nix
#   ];
# }

