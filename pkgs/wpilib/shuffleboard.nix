{ buildJavaTool }:

buildJavaTool {
  pname = "shuffleboard";

  name = "Shuffleboard";

  artifactHashes = {
    macarm64 = "sha256-WY6rwftw0fK2acVfsSZsMFHGQnA3vljIpa5GFnoEVgw=";
    macx64 = "sha256-FCzxDHnbXFhMf3cI5LBYVdApD3tJz+X/1sFeG3upmi4=";
    linuxarm64 = "sha256-le/FT5w9Hl/b+vp5v8X+a9qIUcIzxvhledO08PqIISA=";
    linuxx64 = "sha256-vpM2LETutKFn4OyAQh6SrTjPH4HuQPEapfO7+sIvLTk=";
    linuxarm32 = "sha256-Lh49scOOkWwpR4P2W8ttLpIyK2savKn5b+pZcFKiLyc=";
  };

  iconSvg = ./wpilib_logo.svg;

  meta = {
    description = "A straightforward, customizable driveteam-focused dashboard for FRC";
  };
}
