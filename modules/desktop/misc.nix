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
    lutris

    # Libre office
    # libreoffice
    # # pkgs-stable.libreoffice
    # pkgs-stable.libreoffice-qt
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    vistafonts
    corefonts

    # Plex media player
    plex-media-player

    # postgresql cli ++
    pgcli
  ];

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/user/.steam/root/compatibilitytools.d";
  };

  # services.mysql = {
  #   enable = true;
  #   # package = pkgs.mariadb;
  #   package = pkgs.mysql84;
  # };
  services.postgresql = {
    enable = true;
    ensureDatabases = ["mydatabase"];
    # settings = {
    #   ssl = true;
    # };
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host  all       all     0.0.0.0/0 scram-sha-256
    '';
  };
}
