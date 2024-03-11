{ pkgs, lib }:

lib.makeScope pkgs.newScope (self: with self; {
  buildBinTool = callPackage ./build-bin-tool.nix { };
  buildJavaTool = callPackage ./build-java-tool.nix { };

  datalogtool = callPackage ./datalogtool.nix { };
  glass = callPackage ./glass.nix { };
  outlineviewer = callPackage ./outlineviewer.nix { };
  pathweaver = callPackage ./pathweaver.nix { };
  roborioteamnumbersetter = callPackage ./roborioteamnumbersetter.nix { };
  robotbuilder = callPackage ./robotbuilder.nix { };
  shuffleboard = callPackage ./shuffleboard.nix { };
  smartdashboard = callPackage ./smartdashboard.nix { };
  sysid = callPackage ./sysid.nix { };
})
