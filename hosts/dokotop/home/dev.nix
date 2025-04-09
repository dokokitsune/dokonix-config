{ pkgs, ... }: {
  home.packages = with pkgs; [
   
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
