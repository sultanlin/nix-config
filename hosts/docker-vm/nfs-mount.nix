{
  config,
  username,
  ...
}: {
  # mount a smb/cifs share
  fileSystems."/home/${username}/truenas/Backup" = {
    device = "truenas:/mnt/SingleHDD/Backup";
    fsType = "nfs";
    # options = [
    #   # "vers=3.0,uid=1000,gid=100,dir_mode=0755,file_mode=0755,mfsymlinks,credentials=${config.age.secrets.smb-credentials.path},nofail"
    #   "nfsvers=4.2,defaults"
    # ];
  };
  fileSystems."/home/${username}/truenas/PlexMedia" = {
    device = "truenas:/mnt/Plex/PlexStorage";
    fsType = "nfs";
  };
  fileSystems."/home/${username}/truenas/temporary" = {
    device = "truenas:/mnt/largest-used/temporary-backup";
    fsType = "nfs";
  };
}
