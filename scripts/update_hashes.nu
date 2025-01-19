#! /usr/bin/env nix-shell
#! nix-shell -i nu -p nushell nix-prefetch-github

def get_latest_wpilib_version [] {
    let resp = (curl -s https://api.github.com/repos/wpilibsuite/allwpilib/releases/latest | from json)
    $resp.tag_name | str replace 'v' ''
}

def "main" [] {
    let version = (get_latest_wpilib_version)
    print $"version = ($version);"

    let tools = [DataLogTool, Glass, OutlineViewer, PathWeaver, roboRIOTeamNumberSetter, Shuffleboard, SmartDashboard, SysId]

    for tool in $tools {
        let folder = (http get $"https://frcmaven.wpi.edu/artifactory/api/storage/release/edu/wpi/first/tools/($tool)/($version)" | from json)
        let children = (
            $folder.children
                | where not folder
                | get uri
                | each { |it| $"($folder.uri)/($it)" }
                | par-each { |it| (http get $it | from json) }
        )

        let systems = [linuxarm32, linuxarm64, linuxx86-64, linuxx64, osxuniversal, macarm64, macx64];

        let artifacts = (
            $children
                | insert system { |row|
                    let candidates = $systems | filter { |system| $row.path | str contains $system }
                    if ($candidates | length) > 0 {
                        $candidates | first
                    } else {
                        null
                    }
                }
                | where system != null
                | insert hash { |row| nix hash to-sri --type sha256 $row.checksums.sha256 | str trim }
        )

        print $"\n($tool):"
        print (
            $artifacts
                | each { |it| $'($it.system) = "($it.hash)";' }
                | str join "\n"
        )
    }

    print $"\n---\nNow the non standard ones!\n---"

    let robotbuilder_url = $"https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/tools/RobotBuilder/($version)/RobotBuilder-($version).jar"
    let robotbuilder_sha = (curl -sL $robotbuilder_url | sha256sum | cut -d ' ' -f1)
    let robotbuilderHash = (nix hash to-sri --type sha256 $robotbuilder_sha | str trim)

    print $"\nrobotbuilder:"
    print $'hash = "($robotbuilderHash)";'

    let allwpilib = (nix-prefetch-github --json wpilibsuite allwpilib --rev v($version) | from json)

    print "\nallwpilib (default.nix):"
    print $'passthru.version = "($version)";'
    print $'hash = "($allwpilib.hash)";'
}
