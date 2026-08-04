{
  flake.modules.nixos.base = {
    services.gnome.gnome-keyring.enable = true;
  };
}
