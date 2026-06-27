local@{ ... }:
{
  perSystem = { config, ... }: with local.lib;
    {
      shellEnvs.default =
        with config.shellEnvs;
        mkMerge [
          just
          nix
        ];
    };
}
