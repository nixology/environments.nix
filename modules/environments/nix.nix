{ inputs, ... }:
{
  # re-export nix environment component from flake components
  flake.components = {
    nixology.environments = with inputs.flake.components; {
      inherit (nixology.environments) nix;
    };
  };
}
