{
  config,
  lib,
  pkgs,
  pkgs-stable,
  ...
}: {
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Gaming
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Games?
    mangohud
    protonup

    # Libre office
    libreoffice
    # # pkgs-stable.libreoffice
    # pkgs-stable.libreoffice-qt
    # # libreoffice-qt
    hunspell
    hunspellDicts.en_US
    vistafonts
    corefonts
  ];

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/user/.steam/root/compatibilitytools.d";
  };
}
