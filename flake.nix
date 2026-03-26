{
  description = "Environments for development and deployment";

  inputs.flake.url = "github:nixology/flake";

  outputs =
    inputs: with inputs.flake.lib; mkFlake { inherit inputs; } { imports = modulesIn ./modules; };
}
