{
  nix.settings = {
    substituters = [
    "https://cache.nixos.org"
      "https://hyprland.cachix.org"
      "https://walker.cachix.org"

      "https://cache.flox.dev"
    ];
    trusted-public-keys = [
"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
    ];

  };

}
