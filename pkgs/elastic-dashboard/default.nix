{ lib
, flutter
, fetchFromGitHub
, copyDesktopItems
, makeDesktopItem
,
}:
flutter.buildFlutterApplication rec {
  pname = "elastic-dashboard";
  version = "2025.0.2";

  src = fetchFromGitHub {
    owner = "Gold872";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-O0WzEg8ttpUEh4YaJ0sCBNWo5MHyeF1xsDLh6/HAZRg=";
  };

  pubspecLock = lib.importJSON ./pubspec.lock.json;

  nativeBuildInputs = [ copyDesktopItems ];

  # Get everything out of $out/app to avoid conflicts with other flutter packages
  postInstall = ''
    mkdir "$out"/opt
    mv "$out"/app "$out"/opt/${pname}
    ln -sf "$out"/opt/${pname}/elastic_dashboard "$out"/bin/elastic_dashboard
    install -Dm444 ${src}/assets/logos/logo.png "$out"/share/pixmaps/${pname}.png
  '';

  desktopItems = [
    (makeDesktopItem {
      desktopName = "Elastic";
      name = pname;
      exec = "elastic_dashboard";
      icon = pname;
      comment = meta.description;
      categories = [ "Development" ];
      keywords = [ "FRC" "Dashboard" ];
    })
  ];

  meta = with lib; {
    mainProgram = "elastic_dashboard";
    description = "A simple and modern dashboard for FRC";
    homepage = "https://github.com/Gold872/elastic-dashboard";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
