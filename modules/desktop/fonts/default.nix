{pkgs, ...}:
# all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
let
  monolisa-typeface = pkgs.callPackage ./monolisa.nix {};
  pragmata-pro = pkgs.callPackage ./pragmatapro.nix {};
in {
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;
    fontDir.enable = true;
    fontconfig.enable = true;

    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      carlito # NixOS
      vegur # NixOS
      corefonts # MS

      # Consider Dejavu sans
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      noto-fonts

      source-sans
      source-serif
      source-han-sans
      source-han-serif

      #     # symbols icon only
      #     "NerdFontsSymbolsOnly"
      # nerdfont names
      # https://github.com/NixOS/nixpkgs/tree/master/pkgs/data/fonts/nerd-fonts
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.hack
      nerd-fonts.meslo-lg
      nerd-fonts.sauce-code-pro

      nerd-fonts.comic-shanns-mono
      nerd-fonts.mononoki

      julia-mono
      dejavu_fonts
      wqy_zenhei

      # (pkgs.callPackage ../../fonts/icomoon-feather-icon-font.nix {})
      monolisa-typeface
      pragmata-pro
    ];

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif CJK SC" "Noto Serif CJK TC" "Noto Serif CJK JP" "Noto Color Emoji"];
      sansSerif = ["Noto Sans CJK SC" "Noto Sans CJK TC" "Noto Sans CJK JP" "Noto Color Emoji"];
      monospace = ["MonoLisa" "Symbols Nerd Font Monk" "Noto Color Emoji"];
      # monospace = ["ComicShannsMono Nerd Font" "Noto Color Emoji"];
      # monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      # monospace = ["Iosevka Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };
  environment.sessionVariables = {
    FONTCONFIG_PATH = "/etc/fonts";
  };

  # # https://wiki.archlinux.org/title/KMSCON
  # services.kmscon = {
  #   # Use kmscon as the virtual console instead of gettys.
  #   # kmscon is a kms/dri-based userspace virtual terminal implementation.
  #   # It supports a richer feature set than the standard linux console VT,
  #   # including full unicode support, and when the video card supports drm should be much faster.
  #   enable = true;
  #   fonts = [
  #     {
  #       name = "Source Code Pro";
  #       package = pkgs.source-code-pro;
  #     }
  #   ];
  #   extraOptions = "--term xterm-256color";
  #   extraConfig = "font-size=12";
  #   # Whether to use 3D hardware acceleration to render the console.
  #   hwRender = true;
  # };
}
