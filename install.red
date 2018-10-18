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
.redlang [alias download to-file confirm join]
.quickrun [run]

.install: function [
    'param>url [word! string! file! path! url!] 
    /folder 'param>download-folder [word! string! file! url! path!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][
    const>download-url: form :param>url

    >builds: [
        0.0.0.0.1.6 {adding _debug message}
        0.0.0.0.1.5 {buggy}
    ] 

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    if _debug [
        do https://redlang.red/to-trace
    ]

    either folder [
        if _debug [
            do-trace 50 [
                ?? param>download-folder
            ] %install.6.red
        ]
        param>download-folder: to-red-file form param>download-folder
        either _debug [
            downloaded-file>out: .download/folder/_debug (const>download-url) (to-local-file param>download-folder)
        ][
            downloaded-file>out: .download/folder (const>download-url) (to-local-file param>download-folder)
        ]
    ][
        either _debug [
            downloaded-file>out: .download/_debug (const>download-url)
        ][
            downloaded-file>out: .download (const>download-url)
        ]
    ]

    ; --- run install ---
    if _debug [
        do-trace 70 [
            ?? downloaded-file>out
        ] %install.6.red
        
    ]
    if .confirm (.join ["you want to run the downloaded file:" {"} downloaded-file>out {"}]) [
        .run (downloaded-file>out)
    ]
]

install: :.install
