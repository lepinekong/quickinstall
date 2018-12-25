Red [
    Title: "install nodejs"
    UUID: #d7fdb908-af8d-4781-b30c-2d2d4ab5918e
    Builds: [
		[0.0.0.1.3 {if object? (environment>OS)}]
		[0.0.0.1.3 {fixed bug environment>OS: system/platform/OS}]
		[0.0.0.1.2 {>url: Select >platforms-urls environment>OS}]
		[0.0.0.1.2 {do-trace 20 [}]
		[0.0.0.1.2 {>url: https://nodejs.org/dist/v10.14.0/node-v10.14.0-x64.msi}]
		[0.0.0.1.2 {release}]
		[0.0.0.1.1 {initial build}]
    ]
]

unless value? '.install [
    do https://quickinstall.red
]

.install-nodejs: function[
    /_debug
][
    >platforms-urls: [
        Windows: https://nodejs.org/dist/v10.14.0/node-v10.14.0-x64.msi
    ]
    
    environment>OS: system/platform
    if object? (environment>OS) [
        environment>OS: system/platform/OS
    ]
    
    >url: Select >platforms-urls environment>OS

    if none? >url [
        print [{no download url found for} {nodejs} {in} environment>OS {environment.}]
        >url: ask "Give download url:"
        if >url = "" [
            print ["abort downloading" "nodejs" "."]
            return false
        ]
        
    ]

    either _debug [
        do-trace 20 [
            ?? >url
        ] %nodejs.2.red
        
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value
]

install-nodejs: :.install-nodejs
install-node: :.install-nodejs
