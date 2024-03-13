{ lib, stdenv, fetchurl, makeWrapper, copyDesktopItems, makeDesktopItem, temurin-jre-bin-17 }:

stdenv.mkDerivation rec {
  pname = "robotbuilder";
  version = "2024.3.1";

  src = fetchurl {
    url = "https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/RobotBuilder/${version}/RobotBuilder-${version}.jar";
    hash = "sha256-MPldiaJCjyVhZnaMO5ody6DToOnzg7+7lQzBe2MfGYM=";
  };

  dontUnpack = true;

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp $src $out/lib/RobotBuilder.jar
    makeWrapper ${temurin-jre-bin-17}/bin/java $out/bin/robotbuilder \
      --add-flags "-jar $out/lib/RobotBuilder.jar"

    install -Dm 555 ${./wpilib_logo.svg} $out/share/icons/hicolor/scalable/apps/RobotBuilder.svg

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem rec {
      name = "RobotBuilder";
      desktopName = name;
      exec = "robotbuilder";
      comment = meta.description or null;
      icon = name;
    })
  ];

  meta = with lib; {
    description = "An application which generates FRC robot code";
    license = licenses.bsd3;
    maintainers = with maintainers; [ max-niederman ];
    platforms = platforms.all;
  };
}
