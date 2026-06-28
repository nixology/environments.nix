local@{ ... }:
let
  inherit (local.lib)
    mkMerge
    ;
in
{
  perSystem =
    { config, ... }:
    {
      shellEnvs.default =
        with config.shellEnvs;
        mkMerge [
          just
          nix
        ];
    };
}
