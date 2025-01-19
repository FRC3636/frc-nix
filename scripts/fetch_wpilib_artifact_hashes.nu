#! /usr/bin/env nix-shell
#! nix-shell -i nu -p nushell

def "main" [basePath: string] {
    let folder = (http get $"https://frcmaven.wpi.edu/artifactory/api/storage/($basePath)" | from json)
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

    print (
        $artifacts
            | each { |it| $'($it.system) = "($it.hash)";' }
            | str join "\n"
    )
}
