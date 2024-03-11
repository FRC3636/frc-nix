{ buildBinTool }:

buildBinTool rec {
  pname = "sysid";
  version = "2024.3.1";

  artifacts = {
    url = { os, arch }: "https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/SysId/${version}/SysId-${version}-${os}${arch}.zip";
    hashes = {
      linuxarm64 = "sha256-0Jv1xEMx4BiOjWg5kr3zG94zSlyocjScojqHwSfZjWs=";
      linuxx86-64 = "sha256-8UjRN6h3FG4tSgRcpb4nHTzXW5RdKU6cHobLKj0WJws=";
      osxuniversal = "sha256-6e1ukOtWsekFqjag8OvY/ZSN279vuwdZoT8L1fGyr7E=";
      linuxarm32 = "sha256-X4UukX6zFX2DGJ/2+0l7zf7pIYYL/pptjt6EG6PHfwE=";
    };
  };

  meta = {
    description = "A tool for performing system identification on FRC robots";
  };
}