Red [
    Title: ""
    Description: {

    }
]

do https://redlang.red
.redlang [download alias]

.quickinstall: function [
    param>source-url
    /download-folder
    param>download-folder
    /install-folder
    param>install-folder
    /silent
][

    unless download-folder [
        param>download-folder: "d:\download\devtools"
    ]

    unless install-folder [
        param>install-folder: "c:\devtools"
    ]
    
    if url? param>source-url [
        out>filename: download (param>source-url) (param>download-folder)
    ]
    out>filename: %yarn-1.10.1.msi
    out-file: rejoin [param>install-folder "\" out>filename]
    local>command: {msiexec /i "} out-file {" TARGETDIR="} param>install-folder {" /qb}

    unless silent [
        call local>command   
    ]
    
]

.alias .quickinstall [quickinstall .install install]
