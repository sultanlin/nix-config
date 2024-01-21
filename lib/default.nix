{
  lib,
  constants,
  config,
  ...
}: {
  # colmenaSystem = import ./colmenaSystem.nix;
  # macosSystem = import ./macosSystem.nix;
  nixosSystem = import ./nixosSystem.nix;
  attrs = import ./attrs.nix {inherit lib;};
  scanPaths = path:
    builtins.map
    (f: (path + "/${f}"))
    (builtins.attrNames
      (lib.attrsets.filterAttrs
        (
          path: _type:
            (_type == "directory") # include directories
            && (!lib.strings.hasSuffix ".bak" path) # exclude .bak files
            || (
              (path != "default.nix") # ignore default.nix
              && (lib.strings.hasSuffix ".nix" path) # include .nix files
              && (!lib.strings.hasSuffix ".bak" path) # exclude .bak files
            )
        )
        (builtins.readDir path)));
  symlinkConfig = path: config.lib.file.mkOutOfStoreSymlink "${constants.dotfilesConfig}/${path}";
}
