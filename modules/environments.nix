{ inputs, ... }:
{
  perSystem =
    { config, ... }:
    inputs.self.lib.mkComposedEnvironment {
      name = "default";
      environments = with config.environments; [
        bash
        just
        nix
      ];
    };
}
