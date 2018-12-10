Red [
    Title: "red"
    File: "red"
    UUID: #b7ad1ebe-238b-44de-8820-e112c9538140
    Builds: [
		[0.0.0.1.1.1 {initial}]
		[0.0.0.1.1.1 {initial}]
		[0.0.0.1.1.1 {initial}]
		[0.0.0.1.1.1 {intial}]
		[0.0.0.1.1.1 {initial}]
		[0.0.0.1.1.1 {initial build}]
		[0.0.0.1.1.1 {initial build}]
		[0.0.0.1.1.4 {added builds []}]
    ]
    Template: [
        Url: https://codeops.red/res/templates/install.red
        UUID: #fc3d5a36-47ed-4000-9c98-8503fbfc144c
        Date: 2018-12-02
        Location: 'Cambodia
        Builds: [
		[0.0.0.1.1.3 {abort downloading" "https://static.red-lang.org/dl/win/red-064.exe"}]
            [0.0.0.1.1.2 {>url: Select >platforms-urls environment>OS}]
            [0.0.0.1.1.1 {initial build}]
        ]
    ]    
]

unless value? '.install [
    do https://quickinstall.red
]

.install-red: function[
    /_debug
][
    >platforms-urls: [
        Windows: https://static.red-lang.org/dl/win/red-064.exe
    ]
    environment>OS: system/platform

    >url: Select >platforms-urls environment>OS

    if none? >url [
        print [{no download url found for} {nodejs} {in} environment>OS {environment.}]
        >url: ask "Give download url:"
        if >url = "" [
            print ["abort downloading" "https://static.red-lang.org/dl/win/red-064.exe"]
            return false
        ]
        
    ]    
    either _debug [
        do-trace 20 [
            ?? >url
        ] %red
        
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value   
]

install-red: :.install-red
