{ inputs, ... }:
let
  module = with inputs.parts; components.nixology.parts.formatter;
  partitionedModule = {
    partitions.development = { inherit module; };
  };
in
partitionedModule
