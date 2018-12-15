Red [
    Title: "hyper"
    File: "hyper"
    UUID: #3e57d6f8-d43f-43c9-880b-e3fd7db73521
    Builds: [
		[0.0.0.1.1.1 {initial build}]
		[0.0.0.1.1.4 {added builds []}]
    ]
    Template: [
        Url: https://codeops.red/res/templates/install.red
        UUID: #fc3d5a36-47ed-4000-9c98-8503fbfc144c
        Date: 2018-12-02
        Location: 'Cambodia
        Builds: [
		    [0.0.0.1.1.3 {abort downloading" "https://releases.hyper.is/download/win"}]
            [0.0.0.1.1.2 {>url: Select >platforms-urls environment>OS}]
            [0.0.0.1.1.1 {initial build}]
        ]
    ]    
]

unless value? '.install [
    do https://quickinstall.red
]

.install-hyper: function[
    /_debug
][
    >platforms-urls: [
        Windows: https://releases.hyper.is/download/win
    ]
    environment>OS: system/platform

    >url: Select >platforms-urls environment>OS

    if none? >url [
        print [{no download url found for} {nodejs} {in} environment>OS {environment.}]
        >url: ask "Give download url:"
        if >url = "" [
            print ["abort downloading" "https://releases.hyper.is/download/win"]
            return false
        ]
        
    ]    
    either _debug [
        do-trace 20 [
            ?? >url
        ] %hyper
        
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value   
]

install-hyper: :.install-hyper
