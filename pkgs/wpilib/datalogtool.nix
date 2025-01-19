{ buildBinTool, allwpilibSources }:

buildBinTool {
  pname = "datalogtool";

  name = "DataLogTool";

  artifactHashes = {
    osxuniversal = "sha256-oLZeDZD5SXA6gdt8sHVeWkH2xwiWzwhJO4dXX5Yfo/w=";
    linuxarm64 = "sha256-kzusvOqiFv8vaFUtih5tr/ae2TH+yt/vml2IIDydFyU=";
    linuxarm32 = "sha256-pu+SGfje/C8eAfY7HilYdS71+HBHmencTVKNDSJWZE4=";
    linuxx86-64 = "sha256-+cI8N/8ZTe9YD62WXqZu0Z0OzDL3wQ1isFCCUroG2vI=";
  };

  iconPng = "${allwpilibSources}/datalogtool/src/main/native/resources/dlt-512.png";

  meta = {
    description = "A tool for downloading logs from FRC robots";
  };
}
