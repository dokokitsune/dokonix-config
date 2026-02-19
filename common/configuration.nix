{
  config,
  lib,
  nixpkgs,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.

    ./modules
  ];

  # Bootloader.
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
    supportedFilesystems = [ "nfs" ];
  };
  fileSystems."/var/media" = {
    device = "192.168.0.238:/mnt/Bulk/media";
    fsType = "nfs";
    options = [
      "vers=4"
      "rw"
      "auto"
    ];
  };
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

    };

  };
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  networking.networkmanager = {
    enable = true;
  };
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    upower.enable = true;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    gnome.gnome-keyring.enable = true;
    udisks2.enable = true;
    tailscale.enable = true;

  };

  fonts.packages = with pkgs; [
    nerd-fonts.lilex
  ];

  programs = {
    fish.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      package = pkgs.gitFull;
      config.credential.helper = "libsecret";
    };

  };
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };
  users.defaultUserShell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wwood = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Weston Wood";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };


  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
    inputs.ghostty.packages.${pkgs.system}.default
    inputs.flox.packages.${pkgs.system}.default
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    inputs.nvim-config.packages.${pkgs.system}.default
    udiskie
    nvd
  ];
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";

  };
  system.stateVersion = "25.05"; # Did you read the comment?

}
