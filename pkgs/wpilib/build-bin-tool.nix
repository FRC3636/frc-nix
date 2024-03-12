{ lib
, allwpilibSources
, stdenv
, runCommand
, fetchurl
, unzip
, makeWrapper
, copyDesktopItems
, makeDesktopItem
, libgcc
, libGL
, xorg
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
      libGL
      xorg.libX11
    ]
    ++ lib.optionals stdenv.hostPlatform.isLinux [ libgcc.lib ]
    ++ extraLibs
  );

  mainProgram = args.meta.mainProgram or pname;
in
stdenv.mkDerivation ({
  inherit version;

  src = fetchurl {
    url = "https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/${name}/${version}/${name}-${version}-${wpilibSystem.os}${wpilibSystem.arch}.zip";
    hash = artifactHashes."${wpilibSystem.os}${wpilibSystem.arch}" or (throw "No hash for ${wpilibSystem.os}${wpilibSystem.arch}");
  };

  nativeBuildInputs = [ makeWrapper copyDesktopItems unzip ];

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

    install -D ${iconPng} $out/share/pixmaps/${name}.png

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      inherit name;
      desktopName = name;
      exec = mainProgram;
      comment = meta.description or null;
      icon = if iconPng != null then name else null;
    })
  ];

  meta = (with lib; {
    platforms = [ "x86_64-linux" "aarch64-linux" "armv7l-linux" "armv6l-linux" "x86_64-darwin" "aarch64-darwin" ];
    license = licenses.bsd3;
    maintainers = with maintainers; [ max-niederman ];
  } // meta);
} // removeAttrs args [ "name" "artifactHashes" "extraLibs" "meta" ])
