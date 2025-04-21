{ pkgs, ... }:
{
  home.packages = with pkgs; [
    awscli2
    gcc
    cmake
    cargo
    git
    k9s
    kubernetes
    eza
  ];

}
