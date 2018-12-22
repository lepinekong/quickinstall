Red [
    Title: "gitlab-cli"
    File: "gitlab-cli"
    UUID: #9ba084e5-9d45-419a-bb9f-ab8156652ec6
    Builds: [
		[0.0.0.1.1.1 {initial  build}]
		[0.0.0.1.1.4 {added builds []}]
    ]
    Template: [
        Url: https://codeops.red/res/templates/install.red
        UUID: #fc3d5a36-47ed-4000-9c98-8503fbfc144c
        Date: 2018-12-02
        Location: 'Cambodia
        Builds: [
		    [0.0.0.1.1.3 {abort downloading" "https://github.com/clns/gitlab-cli/releases/download/0.3.2/gitlab-cli-Windows-x86_64.exe"}]
            [0.0.0.1.1.2 {>url: Select >platforms-urls environment>OS}]
            [0.0.0.1.1.1 {initial build}]
        ]
    ]    
]

unless value? '.install [
    do https://quickinstall.red
]

.install-gitlab-cli: function[
    /_debug
][
    >platforms-urls: [
        Windows: https://github.com/clns/gitlab-cli/releases/download/0.3.2/gitlab-cli-Windows-x86_64.exe
    ]
    environment>OS: system/platform

    >url: Select >platforms-urls environment>OS

    if none? >url [
        print [{no download url found for} {nodejs} {in} environment>OS {environment.}]
        >url: ask "Give download url:"
        if >url = "" [
            print ["abort downloading" "https://github.com/clns/gitlab-cli/releases/download/0.3.2/gitlab-cli-Windows-x86_64.exe"]
            return false
        ]
        
    ]    
    either _debug [
        do-trace 20 [
            ?? >url
        ] %gitlab-cli
        
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value   
]

install-gitlab-cli: :.install-gitlab-cli
