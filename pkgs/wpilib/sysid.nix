{ buildBinTool, allwpilibSources }:

buildBinTool {
  pname = "sysid";

  name = "SysId";

  artifactHashes = {
    linuxarm64 = "sha256-0Jv1xEMx4BiOjWg5kr3zG94zSlyocjScojqHwSfZjWs=";
    linuxx86-64 = "sha256-8UjRN6h3FG4tSgRcpb4nHTzXW5RdKU6cHobLKj0WJws=";
    osxuniversal = "sha256-6e1ukOtWsekFqjag8OvY/ZSN279vuwdZoT8L1fGyr7E=";
    linuxarm32 = "sha256-X4UukX6zFX2DGJ/2+0l7zf7pIYYL/pptjt6EG6PHfwE=";
  };

  iconPng = "${allwpilibSources}/sysid/src/main/native/resources/sysid-512.png";

  meta = {
    description = "A tool for performing system identification on FRC robots";
  };
}
