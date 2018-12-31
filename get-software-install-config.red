Red [
    File: "get-software-install-config"
    Title: "get-software-install-config"
    UUID: #39ba06fd-2eb9-422b-b1c9-c2bb5f01a221
    Builds: [
		[0.0.0.1.1.3 {get-software-install alias}]
		[0.0.0.1.1.3 {fixed bug software-config>out: select (extern>block>config) (word>software)}]
		[0.0.0.1.1.2 {fixed const>url>softwares-repo: https://quickinstall.red/config/install.config}]
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

    ; /  ----------------- config ----------------
    const>url>softwares-repo: https://quickinstall.red/config/install.config

    word>software: to-word form param>software
    extern>block>config: load (const>url>softwares-repo)
    software-config>out: select (extern>block>config) (word>software)
    return (software-config>out)
]

get-software-install-config: :.get-software-install-config
get-install-config: :.get-software-install-config
