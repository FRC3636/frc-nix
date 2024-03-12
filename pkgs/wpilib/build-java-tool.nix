{ lib
, allwpilibSources
, stdenv
, runCommand
, fetchurl
, unzip
, makeWrapper
, temurin-jre-bin-17
, libgcc
, libGL
, xorg
, gtk2
}:

{ name
, pname ? lib.strings.toLower name
, artifactHashes
, iconPng ? null
, extraLibs ? [ ]
, meta ? { }
, ...
} @ args:
let
  inherit (allwpilibSources) version;

  wpilibSystem =
    let
      linuxarm32 = {
        os = "linux";
        arch = "arm32";
      };
      linuxarm64 = {
        os = "linux";
        arch = "arm64";
      };
      linuxx64 = {
        os = "linux";
        arch = "x64";
      };
      macarm64 = {
        os = "mac";
        arch = "arm64";
      };
      macx64 = {
        os = "mac";
        arch = "x64";
      };
    in
      {
        x86_64-linux = linuxx64;
        aarch64-linux = linuxarm64;
        armv7l-linux = linuxarm32;
        armv6l-linux = linuxarm32;
        x86_64-darwin = macx64;
        aarch64-darwin = macarm64;
      }.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  libraryPath = lib.makeLibraryPath (
    [
      libgcc.lib
      libGL
      xorg.libX11
      xorg.libXtst
      gtk2
    ] ++ extraLibs
  );
in
stdenv.mkDerivation ({
  inherit version;

  src = fetchurl {
    url = "https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/${name}/${version}/${name}-${version}-${wpilibSystem.os}${wpilibSystem.arch}.jar";
    hash = artifactHashes."${wpilibSystem.os}${wpilibSystem.arch}" or (throw "No hash for ${wpilibSystem.os}${wpilibSystem.arch}");
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp $src $out/lib/${pname}.jar
    makeWrapper ${temurin-jre-bin-17}/bin/java $out/bin/${pname} \
      --prefix LD_LIBRARY_PATH : "${libraryPath}" \
      --add-flags "-jar $out/lib/${pname}.jar"

    runHook postInstall
  '';

  meta = (with lib; {
    platforms = [ "x86_64-linux" "aarch64-linux" "armv7l-linux" "armv6l-linux" "x86_64-darwin" "aarch64-darwin" ];
    license = licenses.bsd3;
    maintainers = with maintainers; [ max-niederman ];
  } // args.meta or { });
} // removeAttrs args [ "name" "artifactHashes" "extraLibs" "meta" ])
