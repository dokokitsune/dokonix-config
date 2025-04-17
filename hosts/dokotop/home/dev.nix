{ pkgs, ... }:
{
  home.packages = with pkgs; [

    awscli2
    gcc
    cmake
    kubernetes
    k9s
    eza
  ];

}
