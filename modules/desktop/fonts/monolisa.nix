{
  lib,
  stdenv,
  fetchFromGitHub,
}:
# https://yashgarg.dev/posts/nix-custom-fonts/
stdenv.mkDerivation {
  pname = "monolisa-nerdfonts";
  version = "2.012";

  src = fetchFromGitHub {
    owner = "JonyPlo";
    repo = "monolisa-font";
    rev = "44aaf6507692b567e870a6d65e65e66af5bab54d";
    hash = "sha256-WMSD+bZNbWjfe+I5MCvw/gClBG6XuO+tk+Ezb08cGTk=";
  };

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
    description = "Monolisa Nerd Fonts";
    homepage = "https://www.monolisa.dev/";
    platforms = platforms.all;
  };
}
