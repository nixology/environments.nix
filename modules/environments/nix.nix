local@{ ... }:
{
  # re-export nix environment component from flake components
  flake.components = {
    nixology.environments = with local.inputs.flake.components; {
      inherit (nixology.environments) nix;
    };
  };
}
