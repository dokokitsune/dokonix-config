{
  # Primary user account. Contributes to `base` because every host in this repo
  # is a personal machine with this exact user. If a host without this user ever
  # appears (e.g. a headless server), move this to its own named aspect and have
  # only the machines that want it import it.
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      # zsh must be enabled system-wide for it to be a valid login shell.
      programs.zsh.enable = true;

      users.users.wwood = {
        isNormalUser = true;
        description = "Weston Wood";
        shell = pkgs.zsh;
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "audio"
          "video"
        ];
      };
    };
}
