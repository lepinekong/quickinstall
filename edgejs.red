Red [
    File: "install-edgejs"
    Title: "install-edgejs"
    Html-Proxy: https://https://quickinstall.red/edgejs
    Description: {
        install edgejs with npm
    }
    Features: [
        
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
.redlang [alias]

.install-edgejs: function [
    'param>options [word! string! file! url! block! unset!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][

    >builds: 0.0.0.0.1.1

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    switch/default type?/word get/any 'param>options [
        unset! [
            print {TODO:}
        ]
        word! string! file! url! block! [
            param>options: form param>options
            print {TODO:}
        ]
    ] [
        throw error 'script 'expect-arg param>options
    ]
]

.alias .install-edgejs [.install-edgejs]
