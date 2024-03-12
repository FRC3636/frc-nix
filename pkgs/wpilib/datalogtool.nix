{ buildBinTool, allwpilibSources }:

buildBinTool {
  pname = "datalogtool";

  name = "DataLogTool";

  artifactHashes = {
    linuxarm32 = "sha256-1LtRUFbGdStcW84TfZv3N6EWPMpz/QE56LWcsn3nx38=";
    osxuniversal = "sha256-HIhhVN/y8EWysKwkXGlJ2a6ksLOWvxJ8kji2zOlDjuU=";
    linuxarm64 = "sha256-ouuGBTnZHlL909o4YQ6uBp8o+SiwsknVl6P5gvdDXf0=";
    linuxx86-64 = "sha256-wLWvtQtw+9l9WkhT1Ah9qAspbliPgJa4b2d63xFKURQ=";
  };

  iconPng = "${allwpilibSources}/datalogtool/src/main/native/resources/dlt-512.png";

  meta = {
    description = "A tool for downloading logs from FRC robots";
  };
}
