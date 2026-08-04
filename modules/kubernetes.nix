{

  flake.modules.homeManager.kubernetes = { pkgs, ... }: {
    
  home.packages = with pkgs; [
      kubernetes
      cilium-cli
      talosctl
      fluxcd
      flux9s
      k9s
      kustomize 
      kubernetes-helm
    ];
  };
}
