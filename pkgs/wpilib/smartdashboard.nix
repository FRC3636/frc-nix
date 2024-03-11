{ buildJavaTool }:

buildJavaTool rec {
  pname = "smartdashboard";
  version = "2024.3.1";

  artifacts = {
    url = { os, arch }: "https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/SmartDashboard/${version}/SmartDashboard-${version}-${os}${arch}.jar";
    hashes = {
      macx64 = "sha256-YLfOzz7Kad9jq2MvctBEjWo+72oeOkwZxMZJ1Wb+L+Q=";
      linuxx64 = "sha256-YizOJ0ScfS8zrZnZdNohVsXA5qVZtq/L2LhigJmj2cM=";
    };
  };

  meta = {
    description = "A simple and resource-efficient FRC dashboard";
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
  };
}
