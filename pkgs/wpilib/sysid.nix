{ buildBinTool, allwpilibSources }:

buildBinTool {
  pname = "sysid";

  name = "SysId";

  artifactHashes = {
    linuxarm64 = "sha256-Xd8GBqJV/8KdC0iFwYOIKLcKG9tDccTP4EUYlU+O/Xo=";
    osxuniversal = "sha256-eylhiRuINFiqzEBBSGvijwXmNE7CQtp4UznKB2VBvsM=";
    linuxx86-64 = "sha256-IqdsYb3tLaV55VX1trjp58aLuXMRQrOHjrHqV1tL6M8=";
    linuxarm32 = "sha256-jnLKYLfb+g8kaq1+biZD8XFVq8z5K8alTa8UYvkW8Jw=";
  };

  iconPng = "${allwpilibSources}/sysid/src/main/native/resources/sysid-512.png";

  meta = {
    description = "A tool for performing system identification on FRC robots";
  };
}
