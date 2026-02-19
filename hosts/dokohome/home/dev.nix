{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gcc
    talosctl
    cmake
    cargo
    git
    k9s
    kubernetes
    fluxcd
    cilium-cli
    eza
    ansible
    awscli2
    opentofu
  ];

}
