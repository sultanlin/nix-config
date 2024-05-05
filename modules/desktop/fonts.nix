{pkgs, ...}: {
  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
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

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra

      source-sans
      source-serif
      source-han-sans
      source-han-serif

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/data/fonts/nerdfonts/shas.nix
      (nerdfonts.override {
        fonts = [
          # symbols icon only
          "NerdFontsSymbolsOnly"
          # Characters
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
          "SourceCodePro"
          "Hack"
          "Meslo"
        ];
      })
      julia-mono
      dejavu_fonts
      wqy_zenhei

      # (pkgs.callPackage ../../fonts/icomoon-feather-icon-font.nix {})
    ];

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif CJK SC" "Noto Serif CJK TC" "Noto Serif CJK JP" "Noto Color Emoji"];
      sansSerif = ["Noto Sans CJK SC" "Noto Sans CJK TC" "Noto Sans CJK JP" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
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
