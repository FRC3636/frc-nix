{ lib, stdenv, runCommand, fetchurl, unzip, makeWrapper, libgcc, libGL, xorg }:

{ artifacts, extraLibs ? [], ... } @ args:
let
  wpilibSystem = let
    linuxarm32 = {
      os = "linux";
      arch = "arm32";
    };
    linuxarm64 = {
      os = "linux";
      arch = "arm64";
    };
    linuxx86-64 = {
      os = "linux";
      arch = "x86-64";
    };
    osxuniversal = {
      os = "osx";
      arch = "universal";
    };
  in
  {
    x86_64-linux = linuxx86-64;
    aarch64-linux = linuxarm64;
    armv7l-linux = linuxarm32;
    armv6l-linux = linuxarm32;
    x86_64-darwin = osxuniversal;
    aarch64-darwin = osxuniversal;
  }.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  libraryPath = lib.makeLibraryPath (
    [
      libgcc.lib
      libGL
      xorg.libX11
    ] ++ extraLibs
  );
in
stdenv.mkDerivation ({
  src = fetchurl {
    url = artifacts.url {
      inherit (wpilibSystem) os arch;
    };
    hash = artifacts.hashes."${wpilibSystem.os}${wpilibSystem.arch}" or (throw "No hash for ${wpilibSystem.os}${wpilibSystem.arch}");
  };

  nativeBuildInputs = [ unzip makeWrapper ];

  unpackPhase = ''
    runHook preUnpack

    unzip $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    for file in ${wpilibSystem.os}/${wpilibSystem.arch}/*; do
      if [ -f $file ]; then
        install -m 755 $file $out/bin/$(basename $file)
        wrapProgram $out/bin/$(basename $file) \
          --prefix LD_LIBRARY_PATH : "${libraryPath}"
      fi
    done

    runHook postInstall
  '';
  
  meta = (with lib; {
    platforms = [ "x86_64-linux" "aarch64-linux" "armv7l-linux" "armv6l-linux" "x86_64-darwin" "aarch64-darwin" ];
    license = licenses.bsd3;
    maintainers = with maintainers; [ max-niederman ];
  } // args.meta or { });
} // removeAttrs args [ "artifacts" "extraLibs" ])