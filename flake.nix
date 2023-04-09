{
  description = "An experiment using zig for a smarter git archive using lua.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    zig.url = "github:mitchellh/zig-overlay";
    zig.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, zig, flake-utils, ... }:
    let
      # Our supported systems are the same supported systems as the Zig binaries
      systems = builtins.attrNames zig.packages;
    in flake-utils.lib.eachSystem systems (system: rec {
      devShells.default =
        nixpkgs.mkShell { nativeBuildInputs = [ zig.master ]; };
    });
}
