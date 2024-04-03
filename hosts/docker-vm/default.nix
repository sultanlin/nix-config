#############################################################
#
#  Ai - my main computer, with NixOS + I5-13600KF + RTX 4090 GPU, for gaming & daily use.
#
#############################################################
{
  imports = [
    ./nfs-mount.nix
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "docker-vm";
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    hosts = {
      "192.168.1.40" = ["truenas"];
    };

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networkmanager.enable = false;

    # enableIPv6 = true; # disable ipv6
    enableIPv6 = false; # disable ipv6
    useDHCP = false;
    # interfaces.ensp018 = {
    interfaces.ens18 = {
      # useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.1.48";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "192.168.1.1";
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
      #   "119.29.29.29" # DNSPod
      #   "223.5.5.5" # AliDNS
    ];
  };
  powerManagement.cpuFreqGovernor = "performance"; # NOTE: Fixes slow database on server

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
