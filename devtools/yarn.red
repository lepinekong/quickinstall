Red [
    File: "install-yarn"
    Title: "install-yarn"
    Html-Proxy: https://
    Description: {
        
    }
    Features: [
        - optional download folder
    ]
    Builds:[
        0.0.0.1.1.1
    ]
    TODO: [
        1 {allow todo: 1.}
        2 {...}
    ]
]

unless value? '.redlang [
    do https://redlang.red
]
.redlang [alias download to-file]

.install-yarn: function [
    'param>download-folder [word! string! file! url! unset!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][
    const>download-url: https://yarnpkg.com/latest.msi

    >builds: 0.0.0.0.1.1

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    switch/default type?/word get/any 'param>download-folder [
        unset! [
            ;param>download-folder: "d:\download\devtools"
            download (const>download-url)
        ]
        word! string! file! url! block! [
            param>download-folder: to-red-file form param>download-folder
            .download (const>download-url) (to-local-file param>download-folder)
        ]
    ] [
        throw error 'script 'expect-arg param>download-folder
    ]

    
]

.alias .install-yarn [install-yarn]


