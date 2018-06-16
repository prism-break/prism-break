with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "prism-break";
  buildInputs = [ git jq nodejs rsync yarn ];
}
