{ lib, stdenv, fetchurl, makeWrapper, temurin-jre-bin-17 }:

stdenv.mkDerivation rec {
  pname = "robotbuilder";
  version = "2024.3.1";

  src = fetchurl {
    url = "https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/RobotBuilder/${version}/RobotBuilder-${version}.jar";
    hash = "sha256-MPldiaJCjyVhZnaMO5ody6DToOnzg7+7lQzBe2MfGYM=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];
  
  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    cp $src $out/lib/RobotBuilder.jar
    makeWrapper ${temurin-jre-bin-17}/bin/java $out/bin/robotbuilder \
      --add-flags "-jar $out/lib/RobotBuilder.jar"

    runHook postInstall
  '';
}