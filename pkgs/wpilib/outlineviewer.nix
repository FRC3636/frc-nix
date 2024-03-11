{ buildBinTool }:

buildBinTool rec {
  pname = "outlineviewer";
  version = "2024.3.1";

  artifacts = {
    url = { os, arch }: "https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/OutlineViewer/${version}/OutlineViewer-${version}-${os}${arch}.zip";
    hashes = {
      linuxarm64 = "sha256-zd66DRIHasycs+wHeZaPgjw7HNDxViKfGUNDtyqFSK0=";
      linuxarm32 = "sha256-YEHL/5OuMxMQNyyvycsDEhs197OoaCwD/HMabuinsbM=";
      linuxx86-64 = "sha256-y1R0jRsJ0odNHlC21SafQdgn4+eYvm0VKBaHa/MnE3A=";
      osxuniversal = "sha256-Nzj9U9RVEpb9cqk/M8DkCCPpWdmsaNgBUOBgrzNCk1g=";
    };
  };

  meta = {
    description = "A utility used to view, modify and add to the contents of NetworkTables";
  };
}
