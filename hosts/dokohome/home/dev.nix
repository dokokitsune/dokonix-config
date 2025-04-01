{ pkgs, ... }: {
  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; with python3Packages; [
      pip
    ]))
    awscli2
    gcc
    cmake
    #nodejs_22
    cargo
#    tenv
    git
#    lazygit
#    yazi
    kubernetes
    containerd
    eza
  ];

}
