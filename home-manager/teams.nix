{
#  stdenv, dpkg, fetchurl , alsaLib, cups, fontconfig , libsecret, nspr, nss, xorg , autoPatchelfHook, libgnome_keyring3, libuuid, makeWrapper, steam-run, cairo, gtk3 
}:

let

  # Please keep the version x.y.0.z and do not update to x.y.76.z because the
  # source of the latter disappears much faster.
  version = "1.3.00.30857";
  old = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz) {};

in old.stdenv.mkDerivation {
  name = "teamsforlinux-${version}";

  system = "x86_64-linux";

  src = old.fetchurl {
    url = "https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_${version}_amd64.deb";
    sha256 = "06r48h1fr2si2g5ng8hsnbcmr70iapnafj21v5bzrzzrigzb2n2h";
  };

  nativeBuildInputs = with old; [
    autoPatchelfHook
    makeWrapper
    steam-run
    dpkg
  ];

  buildInputs = with old; [ 
cairo
gtk3
libgnome_keyring3
alsaLib
cups
fontconfig
libsecret
nss
libuuid
xorg.libxkbfile
xorg.libX11
xorg.libXtst
xorg.libXScrnSaver
xorg.libxcb
  ];

  unpackPhase = "true";
  installPhase = ''
      mkdir -p $out
      dpkg -x $src $out
      cd $out
      mv usr/* .
      rm -r usr
      mv $out/bin/teams $out/bin/.teams-unwrapped
      makeWrapper ${old.steam-run}/bin/steam-run $out/bin/teams --add-flags $out/bin/.teams-unwrapped
  '';

  meta = with old.stdenv.lib; {
    description = "Linux client for teams";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}

