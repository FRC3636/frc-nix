{ buildBinTool, avahi }:

buildBinTool rec {
  pname = "roborioteamnumbersetter";
  version = "2024.3.1";

  artifacts = {
    url = { os, arch }: "https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/roboRIOTeamNumberSetter/${version}/roboRIOTeamNumberSetter-${version}-${os}${arch}.zip";
    hashes = {
      osxuniversal = "sha256-XoCwerp0nJ95zJ0ZiGixyoSXPHpUtvrLE/yUyE48xVY=";
      linuxarm32 = "sha256-gt3MP/y7R2ou77PTn0yDw+p/CGCBvVUelirEIxMF42Y=";
      linuxarm64 = "sha256-sDEo0yFwNRavB2Um7+dQBVJSUO6nGqYEgT25mh8JNeI=";
      linuxx86-64 = "sha256-S5TA0ClNzPoL+UItjsjRb4jzNmxvaM+ivOU9XnWdbVY=";
    };
  };

  extraLibs = [ avahi ];

  meta = {
    description = "A trajectory generation suite for FRC teams";
  };
}
