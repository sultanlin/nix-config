rec {
  # user information
  # hostname = "vm";
  dotfilesConfig = "/home/sultan/ryan-nixos/modified/dotfiles/config";
  username = "sultan";
  userfullname = "Sultan Linjawi";
  useremail = "skorpion219@hotmail.co.uk";

  allSystemAttrs = {
    # linux systems
    x64_system = "x86_64-linux";
    riscv64_system = "riscv64-linux";
    aarch64_system = "aarch64-linux";
    #darwin systems
    x64_darwin = "x86_64-darwin";
    aarch64_darwin = "aarch64-darwin";
  };
  allSystems = builtins.attrValues allSystemAttrs;
}
