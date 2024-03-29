{
  description = "Advent of Code solutions in Prolog";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      rec {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            aocd
            swiProlog
          ];
        };
      }
    );
}
