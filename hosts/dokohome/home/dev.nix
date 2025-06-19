{ pkgs, ... }:
{
  home.packages = with pkgs; [
    awscli2
    gcc
    talosctl
    cmake
    cargo
    git
    k9s
    kubernetes
    eza
  ];

}
