{ stdenv, dpkg, fetchurl , alsaLib, cups, fontconfig , libsecret, nspr, nss, wrapGAppsHook, xorg , autoPatchelfHook, libgnome_keyring3, libuuid, makeWrapper, steam-run }:

let

  # Please keep the version x.y.0.z and do not update to x.y.76.z because the
  # source of the latter disappears much faster.
  version = "1.3.00.5153";

  src = ./teams_1.3.00.5153_amd64.deb;
in stdenv.mkDerivation {
  name = "teamsforlinux-${version}";

  system = "x86_64-linux";

  src = fetchurl {
    url = "https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_${version}_amd64.deb";
    sha256 = "13c7fmij0gcg6mrjjj2mhs21q7fzdssscwhihzyrmbmj64cd0a69";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    wrapGAppsHook
    makeWrapper
    steam-run
    dpkg
  ];

  buildInputs = [ 
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
      makeWrapper ${steam-run}/bin/steam-run $out/bin/teams --add-flags $out/bin/.teams-unwrapped
  '';

  meta = with stdenv.lib; {
    description = "Linux client for teams";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}

