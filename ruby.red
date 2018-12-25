Red [
    Title: "ruby"
    File: "ruby"
    UUID: #34f6e7d5-be8b-44f7-a580-a1446476400d
    Builds: [
		[0.0.0.1.1.1 {if object? (environment>OS)}]
		[0.0.0.1.1.1 {fixed bug environment>OS: system/platform/OS}]
		[0.0.0.1.1.1 {intial}]
		[0.0.0.1.1.4 {added builds []}]
    ]
    Template: [
        Url: https://codeops.red/res/templates/install.red
        UUID: #fc3d5a36-47ed-4000-9c98-8503fbfc144c
        Date: 2018-12-02
        Location: 'Cambodia
        Builds: [
		[0.0.0.1.1.3 {abort downloading" "https://github.com/oneclick/rubyinstaller2/releases/download/rubyinstaller-2.5.3-1/rubyinstaller-devkit-2.5.3-1-x64.exe"}]
            [0.0.0.1.1.2 {>url: Select >platforms-urls environment>OS}]
            [0.0.0.1.1.1 {initial build}]
        ]
    ]    
]

unless value? '.install [
    do https://quickinstall.red
]

.install-ruby: function[
    /_debug
][
    >platforms-urls: [
        Windows: https://github.com/oneclick/rubyinstaller2/releases/download/rubyinstaller-2.5.3-1/rubyinstaller-devkit-2.5.3-1-x64.exe
    ]
    
    environment>OS: system/platform
    if object? (environment>OS) [
        environment>OS: system/platform/OS
    ]

    if _debug [
        do-trace 35 [
            ?? environment>OS
        ] %ruby.1.red
        
    ]

    >url: Select >platforms-urls environment>OS

    if none? >url [
        print [{no download url found for} {ruby} {in} environment>OS {environment.}]
        >url: ask "Give download url:"
        if >url = "" [
            print ["abort downloading" "https://github.com/oneclick/rubyinstaller2/releases/download/rubyinstaller-2.5.3-1/rubyinstaller-devkit-2.5.3-1-x64.exe"]
            return false
        ]
        
    ]    
    either _debug [
        do-trace 46 [
            ?? >url
        ] %ruby
        
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value   
]

install-ruby: :.install-ruby
