{ pkgs, ... }:
{
  home.packages = with pkgs; [
    talosctl
    awscli2
    gcc
    cmake
    kubernetes
    k9s
    eza
  ];

}
