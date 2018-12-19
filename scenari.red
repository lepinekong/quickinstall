Red [
    Title: "scenari"
    File: "scenari"
    UUID: #7c387fe7-2913-42d3-b978-38c8a3155847
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
		[0.0.0.1.1.3 {abort downloading" "https://download.scenari.software/MyScenari@4.2.1.22/"}]
            [0.0.0.1.1.2 {>url: Select >platforms-urls environment>OS}]
            [0.0.0.1.1.1 {initial build}]
        ]
    ]    
]

unless value? '.redlang [
    do https://redlang.red
]

; unless value? '.install [
;     do https://quickinstall.red
; ]

.install-scenari: function[
    /_debug
][
    >platforms-urls: [
        Windows: https://download.scenari.software/MyScenari@4.2.1.22/myScenari4.2.122_fr-FR_2018031916.exe
    ]
    environment>OS: system/platform

    >url: Select >platforms-urls environment>OS

    if none? >url [
        print [{no download url found for} {nodejs} {in} environment>OS {environment.}]
        >url: ask "Give download url:"
        if >url = "" [
            print ["abort downloading" "https://download.scenari.software/MyScenari@4.2.1.22/myScenari4.2.122_fr-FR_2018031916.exe"]
            return false
        ]
    ]    
    either _debug [
        do-trace 20 [
            ?? >url
        ] %scenari
        
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value   
]

install-scenari: :.install-scenari
