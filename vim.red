Red [
    Title: "vim"
    File: "vim"
    UUID: #e63a9bc3-f9c9-4ee4-8b33-1737a8c30c8e
    Builds: [
		[0.0.0.1.1.1 {initial}]
		[0.0.0.1.1.4 {added builds []}]
    ]
    Template: [
        Url: https://codeops.red/res/templates/install.red
        UUID: #fc3d5a36-47ed-4000-9c98-8503fbfc144c
        Date: 2018-12-02
        Location: 'Cambodia
        Builds: [
		[0.0.0.1.1.3 {abort downloading" "https://ftp.nluug.nl/pub/vim/pc/gvim81.exe"}]
            [0.0.0.1.1.2 {>url: Select >platforms-urls environment>OS}]
            [0.0.0.1.1.1 {initial build}]
        ]
    ]    
]

unless value? '.install [
    do https://quickinstall.red
]

.install-vim: function[
    /_debug
][
    >platforms-urls: [
        Windows: https://ftp.nluug.nl/pub/vim/pc/gvim81.exe
    ]
    environment>OS: system/platform

    >url: Select >platforms-urls environment>OS

    if none? >url [
        print [{no download url found for} {nodejs} {in} environment>OS {environment.}]
        >url: ask "Give download url:"
        if >url = "" [
            print ["abort downloading" "https://ftp.nluug.nl/pub/vim/pc/gvim81.exe"]
            return false
        ]
        
    ]    
    either _debug [
        do-trace 20 [
            ?? >url
        ] %vim
        
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value   
]

install-vim: :.install-vim
