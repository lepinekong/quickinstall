Red [
    File: "install"
    Title: "install"
    UUID: #81ac0331-a490-43f2-8008-af67bcce3f9a
    Builds: [
		[0.0.0.2.2.2 {revert to do https://redlang.red/redlang}]
		[0.0.0.2.2.5 {fixed bug for rstudio. to release}]
		[0.0.0.2.1.1 {#include https://redlang.red/redlang}]
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
]

unless value? '.redlang [
    do https://redlang.red/redlang
]
.redlang [alias to-file confirm join download]
unless value? '.get-software-install-config [
    do https://quickinstall.red/get-software-install-config.red
]

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
        do-trace 74 [
            ?? const>download-url
        ] %install.1.red
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
            do-trace 64 [
                ?? const>download-url
            ] %install.1.red
            
        ]
        either folder [
            param>download-folder: to-red-file form (param>download-folder)
            >local-download-folder: to-local-file (param>download-folder)
            either _debug [
                downloaded-file>out: .download/folder/_debug (const>download-url) (>local-download-folder)
            ][
                downloaded-file>out: .download/folder/_debug (const>download-url) (>local-download-folder)
            ]
        ][
            either _debug [
                do-trace 79 [
                    ?? const>download-url
                ] %install.1.red
                
                downloaded-file>out: .download/_debug (const>download-url)
            ][
                downloaded-file>out: .download (const>download-url)
            ]            
        ]       
    ]

    ..install-keyword: func[/_debug /local >url][
        
        >url: to-url rejoin ["https://quickinstall.red/" param>url]

        if _debug [

            do-trace 96 [
                ?? >url
            ] %install.1.red
            
        ]

        if error? try [
            do (>url)
        ][
            ;load from install.config
            word>software: to-word form param>url
            extern>config>software: .get-software-install-config (word>software)

            if _debug [
                do-trace 110 [
                    ?? word>software
                    ?? extern>config>software
                ] %install.3.red
                
            ]
            if none? (extern>config>software) [
                print ["cannot install" (word>software) ]
                return false
            ]
            param>url: select (extern>config>software) 'Windows
            if _debug [
                do-trace 122 [
                    ?? param>url
                ] %install.3.red
                
            ]
            if none? (param>url) [
                print ["cannot download" (word>software) ]
                return false            
            ] 
            const>download-url: (param>url)
            downloaded-file>out: ..install-url
            return (downloaded-file>out)           
            
        ]
        
        either _debug [
            >command: rejoin ["install-" (param>url) "/_debug"]
            do-trace 139 [
                ?? >url
                ?? >command
            ] %install.1.red
        ][
            >command: rejoin ["install-" param>url]
        ]
        
        if _debug [
            do-trace 147 [
                ?? >command
            ] %install.1.red  
        ]
        do (>command)
        
    ]

    if _debug [
        do-trace 157 [
            ?? folder
        ] %install.1.red
        
    ]
    either folder [
        if _debug [
            do-trace 164 [
                ?? param>download-folder
            ] %install.1.red
        ]
        param>download-folder: to-red-file form (param>download-folder)

        downloaded-file>out: ..install-url
        
    ][

        if _debug [
            do-trace 175 [
                ?? param>url
            ] %install.1.red
        ]        

        either word? param>url [
            either _debug [
                do-trace 182 [
                    ?? param>url
                ] %install.1.red
                downloaded-file>out: ..install-keyword/_debug param>url
            ][
                downloaded-file>out: ..install-keyword param>url
            ]
            exit ; 0.0.0.1.2.6
        ][
            if _debug [
                do-trace 192 [
                    print "executing ..install-url"
                ] %install.1.red
            ]
            downloaded-file>out: ..install-url
        ]
    ]

    ; --- run install ---
    if _debug [
        do-trace 202 [
            ?? downloaded-file>out
        ] %install.1.red
        
    ]

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
        do-trace 221 [
            ?? type
        ] %install.1.red
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
                do-trace 250 [
                    ?? param>what
                ] %install.1.red
                
                .install/_debug (param>what)
            ][
                .install (param>what)
            ]
        ]
    ][
        throw error 'script 'expect-arg param>details
    ]
]
