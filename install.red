Red [
    File: "install"
    Title: "install"
    Html-Proxy: https://
    Description: {
        
    }
    Features: [
        
    ]
    Builds:[

    ]

]

unless value? '.redlang [
    do https://redlang.red
]
.redlang [alias download to-file confirm]
.quickrun [run]

.install: function [
    'param>url [word! string! file! path! url!] 
    /folder 'param>download-folder [word! string! file! url! path!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][
    const>download-url: form :param>url

    >builds: 0.0.0.0.1.1

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    either folder [
        param>download-folder: to-red-file form param>download-folder
        downloaded-file>out: .download/folder (const>download-url) (to-local-file param>download-folder)
    ][
        downloaded-file>out: .download (const>download-url)
    ]

    ; --- run install ---
    if .confirm (rejoin ["Do you want to run the downloaded file: " downloaded-file>out]) [
        .run (downloaded-file>out)
    ]
    
    
]

install: :.install
