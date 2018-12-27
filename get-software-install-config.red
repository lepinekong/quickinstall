Red [
    File: "get-software-install-config"
    Title: "get-software-install-config"
    UUID: #92bdcbad-1420-4045-902b-746a420d8938
    Builds: [
		[0.0.0.1.1.1 {initial}]
    ]    
    Date-Time: 
    Location: 'France
    Html-Proxy: 
    Purpose: {}
    Description: {
        TODO:
    }
    Features: [
        1 {}
        2 {}
    ]
    Logs: [
        1 {}
        2 {}
    ]
    TODO: [
        1 {allow todo: 1.}
        2 {...}
    ]
    Template: [
        Url: https://codeops.red/res/templates/redlang.red
        UUID: #536e9372-c829-4fa3-90f2-003eb630bffa
        Date-Time: 2018-11-20 22:23:42
        Location: 'Cambodia
        Builds:[
            [0.0.0.1.01.7 {if _debug}]
            [0.0.0.1.01.6 {added date-time}]
        ]
    ]     
]

unless value? '.redlang [
    do https://redlang.red
]
.redlang [alias]

.get-software-install-config: function [
    {Help:
        
    }
    'param>software [any-type!] 
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

    if _debug [
        do-trace 47 [
            ?? param>software
        ] %get-software-install-config.1.red
    ]

    word>software: to-word form param>software
    extern>config: load (const>url>softwares-repo)
    extern>param: select (extern>config) (word>software)
    return (extern>param)
]

.alias .get-software-install-config [get-software-install-config]
