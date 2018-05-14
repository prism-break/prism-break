with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "prism-break";

  buildInputs = [ nodejs yarn ];
}
