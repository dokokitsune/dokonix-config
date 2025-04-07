{ nixpkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  networking.hostName = "dokohome";

}
