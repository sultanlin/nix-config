{
  lib,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "pragmatapro";
  version = "1.0";
  src = ./pragmatapro/.;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    if [ -d "$src/fonts" ]; then
      cp -r $src/fonts/*.ttf $out/share/fonts/truetype/
    else
      echo "No fonts found in $src/fonts"
      exit 0
    fi
  '';

  meta = with lib; {
    description = "Pragmata Pro";
    homepage = "https://fsd.it/shop/fonts/pragmatapro/";
    platforms = platforms.all;
  };
}
