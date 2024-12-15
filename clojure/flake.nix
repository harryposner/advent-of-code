{
  description = "Advent of Code solutions in Clojure";

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
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            aocd  # This isn't the Clojure library; it's the CLI tool
            clojure
            clojure-lsp
          ];
        };
      }
    );
}
