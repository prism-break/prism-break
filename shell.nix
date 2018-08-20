with import <nixpkgs> {};

stdenvNoCC.mkDerivation {
  name = "prism-break";
  buildInputs = [ git jq nodejs rsync ];
}
