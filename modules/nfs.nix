{
  flake.modules.nixos.nfs = {
    boot = {
      supportedFilesystems = [ "nfs" ];
    };
    fileSystems."/var/media" = {
      device = "100.72.21.122:/mnt/Bulk/media";
      fsType = "nfs";
      options = [
        "vers=4"
        "rw"
        "nofail"
        "noauto"
        "x-systemd.automount"
        "x-systemd.mount-timeout=10"
      ];
    };
  };

}
