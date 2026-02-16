{ inputs, lib, ... }:
let
  module = let partition = "development"; in {
    imports = with inputs.parts; [ components.nixology.parts.partitions ];
    partitionedAttrs = lib.genAttrs [ "checks" "formatter" ] (_: partition);
  };
in
module

