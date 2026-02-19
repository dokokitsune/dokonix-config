{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    makemkv
    vlc
    mkvtoolnix
    ffmpeg
  ];
  users.groups.ripper = {
    gid = 3001;
  };
  users.users.ripper = {
    isSystemUser = true;
    uid = 1001;  
    shell = pkgs.bash;
    group = "ripper";
  };


  
}
