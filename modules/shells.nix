{
  perSystem =
    { config, lib, ... }:
    {
      shells.default =
        with config.shells;
        lib.mkMerge [
          bash
          just
          nix
        ];
    };
}
