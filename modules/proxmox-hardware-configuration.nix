{
  lib,
  modulesPath,
  ...
}:
##############################################################################
#
#  Template for Proxmox's VM, mainly based on:
#    https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/virtualisation/proxmox-image.nix
#
#  the url above is used by `nixos-generator` to generate the Proxmox's VMA image file.
#
#  Motivation:  https://github.com/ryan4yin/nix-config/blob/main/modules/nixos/server/proxmox-hardware-configuration.nix
#
##############################################################################
{
  imports = [
    ./base
    ./base.nix

    # (modulesPath + "/profiles/qemu-guest.nix")
    # ./home-manager.nix
    # ./derivations/my-derivations.nix
  ];

  boot = {
    # after resize the disk, it will grow partition automatically.
    # enable = true; # Set it in each VM's hardware configuration manually
    growPartition = true;
    kernelParams = ["console=ttyS0"];
    loader.grub = {
      device = "/dev/sda";

      # we do not support EFI, so disable it.
      efiSupport = false;
      efiInstallAsRemovable = false;

      configurationLimit = 10; # lib.mkDefault 10;
      useOSProber = true;
    };

    loader.timeout = lib.mkForce 3; # wait for 3 seconds to select the boot entry
    initrd.availableKernelModules = ["uas" "virtio_blk" "virtio_pci"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
  };
  # we do not have a /boot partition, so do not mount it.

  # supported file systems, so we can mount any removable disks with these filesystems
  boot.supportedFilesystems = [
    "ext4"
    "btrfs"
    "xfs"
    #"zfs"
    "ntfs"
    "fat"
    "vfat"
    "exfat"
    "cifs" # mount windows share
    "nfs"
  ];

  # it alse had qemu-guest-agent installed by default.
  services.qemuGuest.enable = lib.mkDefault true;
}
