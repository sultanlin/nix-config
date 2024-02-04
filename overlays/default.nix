args:
# execute and import all overlay files in the current directory with the given args
builtins.map
(f: (import (./. + "/${f}") args)) # execute and import the overlay file

(builtins.filter # find all overlay files in the current directory
  
  (
    f:
      f
      != "default.nix" # ignore default.nix
      && f != "README.md" # ignore README.md
      && !args.lib.strings.hasSuffix ".bak" f
  )
  (builtins.attrNames (builtins.readDir ./.)))
# path: _type:
#   (_type == "directory") # include directories
#   && (!lib.strings.hasSuffix ".bak" path) # exclude .bak files
#   || (
#     (path != "default.nix") # ignore default.nix
#     && (lib.strings.hasSuffix ".nix" path) # include .nix files
#     && (!lib.strings.hasSuffix ".bak" path) # exclude .bak files
