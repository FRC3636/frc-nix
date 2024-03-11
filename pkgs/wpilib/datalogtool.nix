{ buildBinTool }:

buildBinTool rec {
  pname = "datalogtool";
  version = "2024.3.1";

  artifacts = {
    url = { os, arch }: "https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/DataLogTool/${version}/DataLogTool-${version}-${os}${arch}.zip";
    hashes = {
      linuxarm32 = "sha256-1LtRUFbGdStcW84TfZv3N6EWPMpz/QE56LWcsn3nx38=";
      osxuniversal = "sha256-HIhhVN/y8EWysKwkXGlJ2a6ksLOWvxJ8kji2zOlDjuU=";
      linuxarm64 = "sha256-ouuGBTnZHlL909o4YQ6uBp8o+SiwsknVl6P5gvdDXf0=";
      linuxx86-64 = "sha256-wLWvtQtw+9l9WkhT1Ah9qAspbliPgJa4b2d63xFKURQ=";
    };
  };

  meta = {
    description = "A tool for downloading logs from FRC robots";
  };
}
