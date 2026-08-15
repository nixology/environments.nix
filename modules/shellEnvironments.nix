{ lib, ... }: {
  perSystem = { config, ... }: {
    shellEnvironments.default =
      with config.shellEnvironments;
      lib.mkMerge [
        just
        nix
      ];
  };
}
