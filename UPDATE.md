# Update Procedure

Hi! This is the procedure for updating the FRC Nix project. This was reverse engineered from the scripts and nix config here so it might not be 100% accurate.

# Pathplanner

1. Bump the version (minus the "v" in the front of the version) in `pkgs/pathplanner/default.nix` to the new version which can be found [here](https://github.com/mjansen4857/pathplanner/releases/latest).
2. Fetch the new hash of the tarball with the following:
```bash
nix-prefetch --option extra-experimental-features flakes 'fetchFromGitHub {
    owner = "mjansen4857";
    repo = "pathplanner";
    rev = "v2025.2.1";
  }'
```
3. Update the `sha256` attribute in `pkgs/pathplanner/default.nix` to the new hash.
4. Download the latest pubspec.lock file from the pathplanner repo, convert to json with [jsonformatter.org/yaml-to-json](https://jsonformatter.org/yaml-to-json), and then replace the `pkgs/pathplanner/pubspec.lock.json` file with the new one.

# Elastic Dashboard

This is essentially the same as the pathplanner update procedure, but with the `pkgs/elastic-dashboard/default.nix` file.

1. Bump the version (minus the "v" in the front of the version) in `pkgs/elastic-dashboard/default.nix` to the new version which can be found [here](https://github.com/Gold872/elastic-dashboard/releases/latest).
2. Fetch the new hash of the tarball with the following:
```bash
nix-prefetch --option extra-experimental-features flakes 'fetchFromGitHub {
    owner = "Gold872";
    repo = "elastic-dashboard";
    rev = "v2025.0.2";
  }'
```
3. Update the `sha256` attribute in `pkgs/elastic-dashboard/default.nix` to the new hash.
4. Download the latest pubspec.lock file from the elastic-dashboard repo, convert to json with [jsonformatter.org/yaml-to-json](https://jsonformatter.org/yaml-to-json), and then replace the `pkgs/elastic-dashboard/pubspec.lock.json` file with the new one.

# Choreo

This one is not a flutter app so its different! 

1. Bump the version in `pkgs/choreo/default.nix` to the new version which can be found [here](https://github.com/SleipnirGroup/Choreo/releases/latest).
2. Fetch the hashes for the icon and appimage. (Note that the url changed during the 2024-2025 update so double check the url)
```bash
nix-prefetch --option extra-experimental-features flakes 'fetchurl {
  url = "https://raw.githubusercontent.com/SleipnirGroup/Choreo/v2025.0.1/src-tauri/icons/icon.svg";}'
```
```bash 
nix-prefetch --option extra-experimental-features flakes 'fetchurl {
    url = "https://github.com/SleipnirGroup/Choreo/releases/download/v2025.0.1/Choreo-v2025.0.1-Linux-x86_64.AppImage";
  }'
```
3. Update the `icon.hash` and `appimageTools.wrapType2.hash` attributes in `pkgs/choreo/default.nix` to the new hashes.

# AdvantageScope

This one is also an appimage but it has multiple appimages for different platforms.

1. Bump the version in `pkgs/advantagescope/default.nix` to the new version which can be found [here](https://github.com/Mechanical-Advantage/AdvantageScope/releases/latest).
2. Fetch the hashes for the x86_64-linux and aarch64-linux appimages as well as the icon.
```bash
nix-prefetch --option extra-experimental-features flakes 'fetchurl {
      url = "https://github.com/Mechanical-Advantage/AdvantageScope/releases/download/v4.1.1/advantagescope-linux-x64-v4.1.1.AppImage";
      hash = "sha256-s9JcUApkAa5V5AYT+4ZqlvsiB0b/P3rptTDHo160P3U=";
    }'
```
```bash
nix-prefetch --option extra-experimental-features flakes 'fetchurl {
      url = "https://github.com/Mechanical-Advantage/AdvantageScope/releases/download/v4.1.1/advantagescope-linux-arm64-v4.1.1.AppImage";
      hash = "sha256-MgPCiOv8Fpvlg8V8H+3Oe+IpyY6jwi6W49yLzwmSeKI=";
    }'
```
```bash
nix-prefetch --option extra-experimental-features flakes 'fetchurl {
    url = "https://raw.githubusercontent.com/Mechanical-Advantage/AdvantageScope/v4.1.1/icons/window-icon.png";
    hash = "sha256-gqcCqthqM2g4sylg9zictKwRggbaALQk9ln/NaFHxdY=";
  }'
```
