{ buildJavaTool }:

buildJavaTool {
  pname = "pathweaver";

  name = "PathWeaver";

  artifactHashes = {
    linuxarm64 = "sha256-aZsY4cXcVn14PhKCO+tj0dTCrV8rfBPmj81mh9V81iY=";
    macarm64 = "sha256-A7JkghnOO/+l/fiHGnQHJpZ6umOepE/MQmtfZ+nPPck=";
    linuxx64 = "sha256-BFYp9duB2pEO8dBtdrJTukOpV6CRERo3W7NQg2Ulglc=";
    linuxarm32 = "sha256-7vUkvRXwVl15PU/riPl7KYNmWBGrwSwavw8m0feYcVQ=";
    macx64 = "sha256-N5BRM4sKx3EaVMKm/9PZUDNnwTuuBnYHkOrsPHfXams=";
  };

  iconSvg = ./wpilib_logo.svg;

  meta = {
    description = "A trajectory generation suite that for FRC teams to generate and follow trajectories";
  };
}
