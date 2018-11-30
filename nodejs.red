Red [
    Title: "install nodejs"
    UUID: #5904b3d3-1e71-4ed6-a028-5fc81b96813f
    Builds: [
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
