{ ... }@local:
let
  inherit (local.lib) mkMerge;
in
{
  perSystem =
    { config, ... }:
    {
      shellEnvironments.default =
        with config.shellEnvironments;
        mkMerge [
          just
          nix
        ];
    };
}
