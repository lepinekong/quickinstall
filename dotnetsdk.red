Red [
    Title: "dotnetsdk"
    File: "dotnetsdk"
    UUID: #15d8fc24-0532-4f2a-b559-ce14ebefa0dc
    Builds: [
		[0.0.0.1.1.1 {initial}]
		[0.0.0.1.1.4 {added builds []}]
    ]
    Links: [
        https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial
    ]
    Template: [
        Url: https://codeops.red/res/templates/install.red
        UUID: #fc3d5a36-47ed-4000-9c98-8503fbfc144c
        Date: 2018-12-02
        Location: 'Cambodia
        Builds: [
		    [0.0.0.1.1.3 {abort downloading" "https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial"}]
            [0.0.0.1.1.2 {>url: Select >platforms-urls environment>OS}]
            [0.0.0.1.1.1 {initial build}]
        ]
    ]    
]

unless value? '.install [
    do https://quickinstall.red
]

.install-dotnetsdk: function[
    /_debug
][
    >platforms-urls: [
        Windows: https://download.visualstudio.microsoft.com/download/pr/b43f1987-60d5-4fb1-9e9a-1443fff8472d/ffdb11b6d29038c891810dd9db24f23b/dotnet-sdk-2.2.101-win-gs-x64.exe
    ]
    environment>OS: system/platform

    >url: Select >platforms-urls environment>OS

    if none? >url [
        print [{no download url found for} {nodejs} {in} environment>OS {environment.}]
        >url: ask "Give download url:"
        if >url = "" [
            print ["abort downloading" >url]
            return false
        ]
        
    ]    
    either _debug [
        do-trace 20 [
            ?? >url
        ] %dotnetsdk
        
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value   
]

install-dotnetsdk: :.install-dotnetsdk
