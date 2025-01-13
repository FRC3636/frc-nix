{ lib, fetchurl, appimageTools, makeDesktopItem }:

let
  pname = "choreo";
  version = "2025.0.1";

  desktopItem = makeDesktopItem {
    type = "Application";
    name = "Choreo";
    desktopName = "Choreo";
    comment = "A graphical tool for planning time-optimized trajectories for autonomous mobile robots in the FIRST Robotics Competition.";
    icon = "choreo";
    exec = "choreo %u";
  };

  icon = fetchurl {
    url = "https://raw.githubusercontent.com/SleipnirGroup/Choreo/v${version}/src-tauri/icons/icon.svg";
    hash = "sha256-HKCzFijS08MKwsMsfTW9ohxWDqyqhRpLhuBjwVWWKPE=";
  };
in
appimageTools.wrapType2 {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/SleipnirGroup/Choreo/releases/download/v${version}/Choreo-v${version}-Linux-x86_64.AppImage";
    hash = "sha256-SYlB7dabz/jzF9uLnIeURvZlzlQe/pTyd5xwMDMrCDk=";
  };

  extraInstallCommands = ''
    mv $out/bin/${pname}-${version} $out/bin/${pname}
    install -D "${desktopItem}/share/applications/"* -t $out/share/applications/
    install -D ${icon} $out/share/pixmaps/choreo.svg
  '';

  meta = with lib; {
    description = "A graphical tool for planning time-optimized trajectories for autonomous mobile robots in the FIRST Robotics Competition";
    homepage = "https://sleipnirgroup.github.io/Choreo/";
    license = licenses.bsd3;
    mainProgram = "choreo";
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ max-niederman ];
  };
}
