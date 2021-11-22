with import <nixpkgs> {};

pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      clojure
    ];
}
