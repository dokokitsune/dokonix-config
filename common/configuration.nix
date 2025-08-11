# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

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
    device = "10.246.144.2:/mnt/Bulk/k8s/nfs";
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
  # Enable networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [ networkmanager-openconnect ];
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
    nerd-fonts.fira-code
  ];

  nvim = {
    enable = true;
  };
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
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  # Install firefox.

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
    inputs.ghostty.packages.${pkgs.system}.default
    inputs.flox.packages.${pkgs.system}.default
    udiskie
    networkmanagerapplet
    catppuccin-sddm
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
