with import <nixpkgs> {}; rec {
  cef_binary = stdenv.mkDerivation {
    name = "cef_binary_3.3282.1741.gcd94615_linux64";
    src = fetchurl {
      url = http://opensource.spotify.com/cefbuilds/cef_binary_3.3282.1741.gcd94615_linux64.tar.bz2;
      sha256 = "09gz63nm8v2imkhvkhq2chg4sxfjgckj7jsghv7hc40yz4v87gkp";
    };
    buildInputs = [ stdenv cmake ];
    buildPhase = ''
      make libcef_dll_wrapper
    '';
    installPhase = ''
      mkdir -p $out/lib
      cp libcef_dll_wrapper/libcef_dll_wrapper.a $out/lib
    '';
  };

  obs-linuxbrowser = stdenv.mkDerivation {
    name = "obs-linuxbrowser";
    src = fetchFromGitHub {
      owner = "bazukas";
      repo = "obs-linuxbrowser";
      rev = "fe993a9a2748e304419fa2bd6a0f8024275bc97b";
      sha256 = "1m0164yx01zxrnxv8xv4x491ahyjak86ijh72bnh1sajgapkgz42";
    };

    buildInputs = [ gcc cmake cef_binary ];
  };
}
