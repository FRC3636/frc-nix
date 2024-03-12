{ buildBinTool, allwpilibSources }:

buildBinTool {
  pname = "outlineviewer";

  name = "OutlineViewer";

  artifactHashes = {
    linuxarm64 = "sha256-zd66DRIHasycs+wHeZaPgjw7HNDxViKfGUNDtyqFSK0=";
    linuxarm32 = "sha256-YEHL/5OuMxMQNyyvycsDEhs197OoaCwD/HMabuinsbM=";
    linuxx86-64 = "sha256-y1R0jRsJ0odNHlC21SafQdgn4+eYvm0VKBaHa/MnE3A=";
    osxuniversal = "sha256-Nzj9U9RVEpb9cqk/M8DkCCPpWdmsaNgBUOBgrzNCk1g=";
  };

  iconPng = "${allwpilibSources}/outlineviewer/src/main/native/resources/ov-512.png";

  meta = {
    description = "A utility used to view, modify and add to the contents of NetworkTables";
  };
}
