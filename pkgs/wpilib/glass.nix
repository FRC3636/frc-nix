{ buildBinTool }:

buildBinTool rec {
  pname = "glass";
  version = "2024.3.1";

  artifacts = {
    url = { os, arch }: "https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/Glass/${version}/Glass-${version}-${os}${arch}.zip";
    hashes = {
      osxuniversal = "sha256-GEh+OjehYf9yMn0cwfN5fb8ADu3vEBAg3mWh5sCIG6E=";
      linuxx86-64 = "sha256-ZNYNZX1Vs+j3123HibKwXRjd91pLrIB9nPSEyPyk9J8=";
      linuxarm64 = "sha256-4+B8pPoahIwExEv/EKsOF4M+fJdozQlWF2kdQbfJ+XM=";
      linuxarm32 = "sha256-NacpM8O58+po2xO73tHNnL9v0Lt2ePQmeWDB+9x+jbw=";
    };
  };

  meta = {
    description = "A dashboard and data visualization tool for FRC robots";
  };
}
