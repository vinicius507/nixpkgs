{ lib
, stdenv
, fetchFromGitHub
, autoreconfHook
, alsa-lib
, fftw
, iniparser
, libpulseaudio
, ncurses
, pkgconf
, SDL2
, withSDL2 ? false
}:

stdenv.mkDerivation rec {
  pname = "cava";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "karlstav";
    repo = "cava";
    rev = version;
    hash = "sha256-W/2B9iTcO2F2vHQzcbg/6pYBwe+rRNfADdOiw4NY9Jk=";
  };

  buildInputs = [
    alsa-lib
    fftw
    libpulseaudio
    ncurses
    iniparser
  ]++ lib.optional withSDL2 SDL2;

  nativeBuildInputs = [
    autoreconfHook
    pkgconf
  ];

  preAutoreconf = ''
    echo ${version} > version
  '';

  meta = with lib; {
    description = "Console-based Audio Visualizer for Alsa";
    homepage = "https://github.com/karlstav/cava";
    license = licenses.mit;
    maintainers = with maintainers; [ offline mirrexagon ];
    platforms = platforms.linux;
    mainProgram = "cava";
  };
}
