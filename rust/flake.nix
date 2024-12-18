{
  description = "Advent of Code solutions in Rust";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustup
            rust-analyzer
          ]
          ++ lib.optionals (system == "aarch64-darwin") [
            libiconv
            darwin.apple_sdk.frameworks.Security
            pkgconfig
            openssl
          ];
        };
      }
    );
}
