{
  description = "A Nix-flake-based Go 1.17 development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  # inputs.gomod2nix.url = "github:nix-community/gomod2nix";
  # inputs.gomod2nix.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {
    self,
    nixpkgs,
    # gomod2nix,
  }: let
    goVersion = 20; # Change this to update the whole stack
    overlays = [(final: prev: {go = prev."go_1_${toString goVersion}";})];
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {inherit overlays system;};
          # callPackage = nixpkgs.legacyPackages.${system}.callPackage;
          # callPackage = pkgs.callPackage;
        });
  in {
    devShells = forEachSupportedSystem (
      {pkgs}: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            # go 1.20 (specified by overlay)
            go

            # goimports, godoc, etc.
            gotools

            # https://github.com/golangci/golangci-lint
            golangci-lint
          ];
        };
        # packages.default = callPackage ./. {
        #   inherit (gomod2nix.legacyPackages.${system}) buildGoApplication;
        # };
        # devShells.default = callPackage ./shell.nix {
        #   inherit (gomod2nix.legacyPackages.${system}) mkGoEnv gomod2nix;
        # };
      }
    );
  };
}
# {
#   description = "A basic gomod2nix flake";
#
#   outputs = { self, nixpkgs, flake-utils, gomod2nix }:
#     (flake-utils.lib.eachDefaultSystem
#       (system:
#         let
#           pkgs = nixpkgs.legacyPackages.${system};
#
#           # The current default sdk for macOS fails to compile go projects, so we use a newer one for now.
#           # This has no effect on other platforms.
#           callPackage = pkgs.darwin.apple_sdk_11_0.callPackage or pkgs.callPackage;
#         in
#         {
#           packages.default = callPackage ./. {
#             inherit (gomod2nix.legacyPackages.${system}) buildGoApplication;
#           };
#           devShells.default = callPackage ./shell.nix {
#             inherit (gomod2nix.legacyPackages.${system}) mkGoEnv gomod2nix;
#           };
#         })
#     );
# }

