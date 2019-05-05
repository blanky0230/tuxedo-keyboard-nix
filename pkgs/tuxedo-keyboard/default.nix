{ stdenv, fetchFromGitHub, linuxPackages, kmod}:

stdenv.mkDerivation rec {
  name = "tuxedo-keyboard-${linuxPackages.kernel.version}-${version}";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "tuxedocomputers";
    repo = "tuxedo-keyboard";
    rev = "1b2d7ecfbfdb29c622d62900d47ee5befefb1b57";
    sha256 = "0hqcl3wa66wxjvaviaqadlws4jl7y0b8pn8mfhny1sdgy75kv3nc";
  };
  

  NIX_DEBUG = 1;

  unpackPhase = ''
    mkdir -p $out/build/src
    cp -r $src/* $out/build
  '';

  patchPhase = ''
    substituteInPlace $out/build/Makefile --replace /lib/modules/ "${linuxPackages.kernel.dev}/lib/modules/"
    substituteInPlace $out/build/Makefile --replace '$(shell uname -r)' "${linuxPackages.kernel.modDirVersion}"
    substituteInPlace $out/build/Makefile --replace './src' 'src'
  '';

  buildPhase = ''
    make -C $out/build
  '';

  installPhase = ''
    mkdir -p "$out/lib/modules/${linuxPackages.kernel.modDirVersion}"
    cp $out/build/src/tuxedo_keyboard.ko $out/lib/modules/${linuxPackages.kernel.modDirVersion}
    rm -rf $out/build
  '';

  meta = {
      description = "Full color keyboard driver for tuxedo computers laptops";
      homepage = "https://example.com";
      platforms = stdenv.lib.platforms.linux;
      maintainer = "blanky0230";
  };
}
