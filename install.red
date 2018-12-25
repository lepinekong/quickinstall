Red [
    File: "install"
    Title: "install"
    UUID: #a528b679-cca1-42ca-8602-5dcff3a72cce
    Builds: [
		[0.0.0.1.2.9 {fixed bug}]
		[0.0.0.1.2.9 {fixed bug}]
		[0.0.0.1.2.9 {fixed bug}]
		[0.0.0.1.2.9 {test OK for ruby}]
		[0.0.0.1.2.9 {removed if confirmed download in src\.install.red\0.0.0.1\02\install.9.red}]
		[0.0.0.1.2.7 {minor refactor >local-download-folder: to-local-file param>download-folder}]
		[0.0.0.1.2.6 {install: function [ .install-extension (param>details)}]
		[0.0.0.1.2.6 {if _debug }]
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
    Html-Proxy: https://quickinstall.red/install
    Description: {
        install library
    }
    Features: [
        1 {download the file}
        1.1 {if keyword call install-<keyword>}
        1.2 {}
        2 {run downloaded file if confirmation}
        2.1 {unzip the file before if necessary}
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
        do-trace 67 [
            ?? const>download-url
        ] %install.5.red
    ]


    >builds: [
    ] 

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    ..install-url: func[
        /folder
    ][
        if _debug [
            do-trace 87 [
                ?? const>download-url
            ] %install.8.red
            
        ]
        either folder [
            param>download-folder: to-red-file form param>download-folder
            >local-download-folder: to-local-file param>download-folder
            either _debug [
                downloaded-file>out: .download/folder/_debug (const>download-url) (>local-download-folder)
            ][
                downloaded-file>out: .download/folder/_debug (const>download-url) (>local-download-folder)
            ]
        ][
            either _debug [
                do-trace 102 [
                    ?? const>download-url
                ] %install.8.red
                
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

    if _debug [
        do-trace 129 [
            ?? folder
        ] %install.8.red
        
    ]
    either folder [
        if _debug [
            do-trace 141 [
                ?? param>download-folder
            ] %install.6.red
        ]
        param>download-folder: to-red-file form (param>download-folder)

        ..install-url
        
        
    ][

        if _debug [
            do-trace 151 [
                ?? param>url
            ] %install.5.red
        ]        

        either word? param>url [
            either _debug [
                do-trace 158 [
                    ?? param>url
                ] %install.7.red
                downloaded-file>out: ..install-keyword/_debug param>url
            ][
                downloaded-file>out: ..install-keyword param>url
            ]
            exit ; 0.0.0.1.2.6
        ][
            if _debug [
                do-trace 168 [
                    print "executing ..install-url"
                ] %install.5.red
            ]
            downloaded-file>out: ..install-url
        ]
    ]

    ; --- run install ---
    if _debug [
        do-trace 128 [
            ?? downloaded-file>out
        ] %install.6.red
        
    ]
    ; if .confirm (rejoin ["you want to run the downloaded file:" {"} downloaded-file>out {"}]) [
    ;     .run (downloaded-file>out)
    ; ]
]

install: function [
    'param>what [word! string! file! path! url!] 
    'param>details [word! string! file! path! url! unset!]
    /_debug
][
    if _debug [
        do https://redlang.red/do-trace 
    ]   

    if _debug [
        type: type?/word get/any 'param>details
        do-trace 200 [
            ?? type
        ] %install.8.red
    ]
    switch/default type?/word get/any 'param>details [
        unset! [
            either _debug [
                .install/_debug (param>what)
            ][
                .install (param>what)
            ]
            
        ]
        word! string![
            either (param>what) = 'extension [
                param>details: form :param>details
                either _debug [
                    .install-extension/_debug (param>details)
                ][
                    .install-extension (param>details)
                ]
                
            ][
                ;TODO:
            ]
        ]

        url! [
            either _debug [
                do-trace 218 [
                    ?? param>what
                ] %install.8.red
                
                .install/_debug (param>what)
            ][
                .install (param>what)
            ]
        ]
    ][
        throw error 'script 'expect-arg param>details
    ]
]
