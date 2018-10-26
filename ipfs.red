Red [
    File: "install-ipfs"
    Title: "install-ipfs"
    Html-Proxy: 
    Description: {
        
    }
    Features: [
        
    ]
    Builds:[
        [0.0.0.1.01.1 {  }]
    ]
    TODO: [
        1 {allow todo: 1.}
        2 {...}
    ]
]

unless value? '.install [
    do https://quickinstall.red
]

.install-ipfs: function [
    {Help:
        
    }
    /target-folder param>target-folder [word! string! file! url! path! paren! block!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][

    if _debug [
        .redlang do-trace
    ]    

    >builds: [
        0.0.0.1.01.1 {Initial Build}
    ]

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    unless target-folder [
        param>target-folder: ask "target-folder: "
    ]

    if _debug [
        do-trace 47 [
            ?? param>target-folder
        ] %redlang.2.red
    ] 

    return .install https://dist.ipfs.io/go-ipfs/v0.4.17/go-ipfs_v0.4.17_windows-386.zip 
]

install-ipfs: function [
    {Help:
        
    }
    'param>target-folder [word! string! file! url! path! paren! block! unset!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][
    if _debug [
        .redlang do-trace
    ]

    >builds: [
        0.0.0.1.01.1 {Initial Build}
    ]

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    switch/default type?/word get/any 'param>target-folder [
        unset! [
            .install-ipfs
        ]
        word! string! file! url! path! paren! block! [
            param>target-folder: form param>target-folder

            do-trace 92 [
                ?? param>target-folder
            ] %redlang.2.red
            
            .install-ipfs/target-folder (param>target-folder)
        ]
    ] [
        throw error 'script 'expect-arg param>target-folder
    ]
]

