Red [
    File: "install"
    Title: "install"
    UUID: #cda22af6-0e2b-41bc-b147-929f2faabf56
    Html-Proxy: https://
    Description: {
        
    }
    Features: [
        
    ]
    Builds:[
    ]
    TODO: [
        Bugs: [
            1 {failed for 
            https://download.visualstudio.microsoft.com/download/pr/7010cdb4-ae43-408b-8c9f-5f94101a1c70/3e1ae56a072c7c397f10278d7643b3e9/dotnet-sdk-2.1.403-win-gs-x64.exe
            on page https://www.microsoft.com/net/learn/dotnet/hello-world-
            }
        ]
    ]

]

unless value? '.redlang [
    do https://redlang.red
]
.redlang [alias download to-file confirm join]
.quickrun [run]

.install: function [
    'param>url [word! string! file! path! url!] 
    /folder 'param>download-folder [word! string! file! url! path!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][

    if _debug [
        do https://redlang.red/do-trace ; 0.0.0.1.01.7: fixed to-trace 
    ]    
    
    const>download-url: form :param>url

    if _debug [
        do-trace 45 [
            ?? const>download-url
        ] %install.5.red
    ]


    >builds: [
		[0.0.0.1.2.6 {install: function [ .install-extension (param>details)}]
		[0.0.0.1.2.6 {if _debug [}]
		[0.0.0.1.2.6 {exit ; 0.0.0.1.2.6}]
		[0.0.0.1.2.5 {release}]
		[0.0.0.1.2.5 {            param>download-folder: to-red-file form param>download-folder}]
		[0.0.0.1.2.5 {fixed stupid bug []}]
		[0.0.0.1.2.5 {_debug}]
		[0.0.0.1.2.5 {_debug}]
		[0.0.0.1.2.5 {_debug}]
		[0.0.0.1.2.3 {remoeved ask "install"}]
		[0.0.0.1.2.3 {temp ask "install"}]
		[0.0.0.1.2.3 {print ["debug: command" command "cannot be executed"]}]
		[0.0.0.1.2.2 {initial release}]
        0.0.0.0.1.6 {adding _debug message}
        0.0.0.0.1.5 {buggy}
    ] 

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]


    ..install-url: func[
        /folder
        /_debug
    ][
        either folder [
            param>download-folder: to-red-file form param>download-folder
            either _debug [
                downloaded-file>out: .download/folder/_debug (const>download-url) (to-local-file param>download-folder)
            ][
                downloaded-file>out: .download/folder/_debug (const>download-url) (to-local-file param>download-folder)
            ]
        ][
            either _debug [
                downloaded-file>out: .download/_debug (const>download-url)
            ][
                downloaded-file>out: .download (const>download-url)
            ]            
        ]       
    ]

    ..install-keyword: func[/_debug /local >url][

        >url: to-url rejoin ["https://quickinstall.red/" param>url]

        do (>url)
        either _debug [
            >command: rejoin ["install-" param>url "/_debug"]
            do-trace 89 [
                ?? >url
                ?? >command
            ] %install.5.red
            
        ][
            >command: rejoin ["install-" param>url]
        ]
        
        if _debug [
            do-trace 102 [
                ?? >command
            ] %install.5.red  
        ]
      
        do (>command)
        
    ]

    either folder [
        if _debug [
            do-trace 101 [
                ?? param>download-folder
            ] %install.6.red
        ]
        param>download-folder: to-red-file form param>download-folder

        ..install-url
    ][


        if _debug [
            do-trace 130 [
                ?? param>url
            ] %install.5.red
        ]        

        either word? param>url [
            either _debug [
                do-trace 114 [
                    ?? param>url
                ] %install.7.red
                downloaded-file>out: ..install-keyword/_debug param>url
            ][
                downloaded-file>out: ..install-keyword param>url
            ]
            exit ; 0.0.0.1.2.6
        ][
            either _debug [
                do-trace 146 [
                    print "executing ..install-url"
                ] %install.5.red
                downloaded-file>out: ..install-url/_debug
                
            ][
                downloaded-file>out: ..install-url
            ]
            
        ]

    ]

    ; --- run install ---
    if _debug [
        do-trace 128 [
            ?? downloaded-file>out
        ] %install.6.red
        
    ]
    if .confirm (rejoin ["you want to run the downloaded file:" {"} downloaded-file>out {"}]) [
        .run (downloaded-file>out)
    ]
]

install: function [
    'param>what [word! string! file! path! url!] 
    'param>details [word! string! file! path! url! unset!]
][
    switch/default type?/word get/any 'param>details [
        unset! [
            .install (param>what)
        ]
        word! string! url! file! [
            either (param>what) = 'extension [
                param>details: form :param>details
                .install-extension (param>details)
            ][
                ;TODO:
            ]
        ]
    ][
        throw error 'script 'expect-arg param>details
    ]
]
