with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "prism-break";
  buildInputs = [ jq nodejs yarn ];
}
