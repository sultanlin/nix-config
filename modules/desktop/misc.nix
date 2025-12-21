{
  config,
  lib,
  pkgs,
  pkgs-stable,
  nurjf,
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
    protonup-ng
    lutris
    gamescope
    rusty-path-of-building

    mgba
    libsForQt5.qt5.qtwayland

    # Libre office
    # libreoffice
    # # pkgs-stable.libreoffice
    # pkgs-stable.libreoffice-qt
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    vista-fonts
    corefonts

    # Plex media player
    # plex-media-player
    # plex-desktop
    jellyfin-media-player
    delfin
    keyd
    dolphin-emu
    usbutils

    # eden_emu

    # postgresql cli ++
    # pgcli

    easyeffects

    # Jetbrains
    jetbrains.idea-oss
    jetbrains.idea
    jetbrains.pycharm
    jetbrains.pycharm-oss

    postman

    slack

    # Database GUI
    # pgadmin4

    # dbeaver-bin
    # pgmanage
    pkgs-stable.orca
    at-spi2-core
  ];

  programs.gamemode.enable = true;
  programs.thunderbird.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/user/.steam/root/compatibilitytools.d";
  };

  # services.mysql = {
  #   enable = true;
  #   package = pkgs.mariadb;
  #   # package = pkgs.mysql84;
  # };

  # services = {
  #   postgresql = {
  #     enable = true;
  #     ensureDatabases = ["mydatabase"];
  #     # settings = {
  #     #   ssl = true;
  #     # };
  #     # initialScript = ''
  #     #   CREATE ROLE pgadmin WITH PASSWORD 'pgadmin' SUPERUSER CREATEROLE CREATEDB REPLICATION BYPASSRLS LOGIN;
  #     #   CREATE DATABASE pgadmin;
  #     #   GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO pgadmin;
  #     #   GRANT ALL PRIVILEGES ON DATABASE postgres TO pgadmin;
  #     #   GRANT ALL PRIVILEGES ON DATABASE pgadmin TO pgadmin;
  #     # '';
  #     authentication = pkgs.lib.mkOverride 10 ''
  #       #type database  DBuser  auth-method
  #       local all       pgadmin peer
  #       local all       sultan  peer
  #       local all       all     trust
  #       host  all       all     0.0.0.0/0 scram-sha-256
  #     '';
  #   };
  #   # pgadmin = {
  #   #   enable = true;
  #   #   initialEmail = "skorpion219@hotmail.co.uk";
  #   #   # initialPasswordFile = config.sops.secrets.pg_pass.path;
  #   #   openFirewall = true;
  #   #   settings = {
  #   #     "ALLOWED_HOSTS" = [
  #   #       "192.168.0.0/16"
  #   #     ];
  #   #     "CONFIG_DATABASE_URI" = "postgresql://pgadmin:pgadmin@localhost/pgadmin";
  #   #   };
  #   # };
  # };
}
