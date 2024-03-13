{ buildJavaTool }:

buildJavaTool {
  pname = "smartdashboard";

  name = "SmartDashboard";

  artifactHashes = {
    macx64 = "sha256-YLfOzz7Kad9jq2MvctBEjWo+72oeOkwZxMZJ1Wb+L+Q=";
    linuxx64 = "sha256-YizOJ0ScfS8zrZnZdNohVsXA5qVZtq/L2LhigJmj2cM=";
  };

  iconSvg = ./wpilib_logo.svg;

  meta = {
    description = "A simple and resource-efficient FRC dashboard";
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
  };
}
