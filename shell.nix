with import <nixpkgs> {};

stdenvNoCC.mkDerivation {
  name = "prism-break";
  nativeBuildInputs = [ git jq nodejs rsync ];
}
