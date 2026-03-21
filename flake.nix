{
  description = "Environments for development and deployment";

  inputs.flake.url = "git+ssh://git@github.com/marksisson/flake";

  outputs =
    inputs: with inputs.flake.lib; mkFlake { inherit inputs; } { imports = modulesIn ./modules; };
}
