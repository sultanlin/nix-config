{
  pkgs,
  # stdenv,
  # fetchurl,
  #   stdenv ? pkgs.stdenv,
  # , fetchurl ? pkgs.fetchurl,
  # lib,
  ...
}:
pkgs.stdenv.mkDerivation rec {
  pname = "jdtls";
  version = "1.33.0";
  src = let
    prefix = "https://download.eclipse.org/jdtls/milestones/${version}";
    tarballPointer = pkgs.fetchurl {
      url = "${prefix}/latest.txt";
      # hash = "sha256-pMRAfw7wuJ1243ETikTgqZBvRYPdWKTcO0GUzh2EQzk=";
      hash = "sha256-bfatEGyPSLctBwu8ZeuHiwWPwEtfhcDWcbyWTuMcYhk=";
      # hash = pkgs.lib.fakeHash;
    };
    filename = builtins.replaceStrings ["\n"] [""] (builtins.readFile tarballPointer);
    url = "${prefix}/${filename}";
  in
    pkgs.fetchurl {
      inherit url;
      # hash = "sha256-sVxrrdH0N7Uz2FdyDXWTwcu27pr7TfsFebcxjj27Lhk=";
      hash = "sha256-UZQQl3lFPmN6Azglf97xevwA6OehO/2bSM0bg93z8YY=";
      # hash = pkgs.lib.fakeHash;
    };
  dontUnpack = true;
  installPhase = ''
    mkdir $out
    tar -xzf $src -C $out
  '';
}
