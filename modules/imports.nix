{ inputs, ... }:
{
  imports = [ inputs.flake.flakeModules.formatter ];
}
