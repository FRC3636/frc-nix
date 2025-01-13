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
