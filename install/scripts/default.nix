{ stdenv }:

stdenv.mkDerivation rec {
  name = "install-script";
  version = "latest";
  buildInputs = [ ] ;  
    
  src = ./.;
  installPhase = ''
    mkdir -p $out/bin
    cp $src/install.sh $out/bin
  '';
}
