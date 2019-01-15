Red [
    Title: "install-extension.red" 
    UUID: #ed57f345-97b6-4e6d-9c25-50fc667a623a
    Build-purpose: {
        install-extension from remote log file
    }
    Builds: [
		[0.0.0.2.2.6 {return true}]
		[0.0.0.2.2.4 {revert to src\vscode\install-extension.red\0.0.0.3\01\install-extension.1.red}]
		[0.0.0.2.2.1 {case arg is an url}]
		[0.0.0.3.1 {case arg is an url}]
    ]
]

    unless value? '.redlang [
        do https://redlang.red/redlang
    ] 
    .redlang [call-powershell log section] 
    
    .install-extension: function [
        '>extension "name or extension url"
        /log-file >log-file 
        /separator >separator 
        /silent 
        /_build
    ] [
        .section "meta" [
            builds>: 0.0.0.1.1 
            if _build [
                unless silent [
                    ?? builds>
                ] 
                return builds
            ] 
        ]


        __VSCODE_EXTENSION_LOG_FILE__: %vscode-extensions.log 

        ..info-path: does [
            print ["log file:" clean-path __VSCODE_EXTENSION_LOG_FILE__]
        ] 
        ..log: does [
            .log/separator (__VSCODE_EXTENSION_LOG_FILE__) (>extension) (>separator)
        ] 
        
        unless separator [
            >separator: "(+)" ; added extension (-) removed extension
        ] 
        either block? >extension [

            .section {/------------- case arg is a block of extensions ------------} [
                >extensions: >extension 
                forall >extensions [
                    extension: >extensions/1 .install-extension/silent (extension)
                ] unless silent [
                    ..info-path
                ]
            ] {------------- case arg is a block of extensions ------------/}
 
        ] [
            .section {/------------- case arg is a single extension ------------} [
                ~url: :>extension
                if url? ~url [
                    parse ~url [thru "itemName=" copy >extension to end]
                ]

                >extension: form >extension 
                either >extension = "from-log" [
                    unless /log-file [
                        >log-file: __VSCODE_EXTENSION_LOG_FILE__
                    ] 
                    either "http" = copy/part >log-file 4 [
                        if error? try [
                            lines: read/lines (>log-file)
                        ][
                            print ["cannot read log file" >log-file]
                            return false
                        ] 
                        if confirm "install-extensions" [
                            extensions-list>: copy [] 
                            forall lines [
                                line: lines/1 parse line [thru [some " "] thru [some " "] copy extension to end] append extensions-list> extension
                            ] 
                            .install-extension (extensions-list>) 
                            return true
                        ]                        

                    ][
                        >log-file: to-red-file form >log-file 
                        either exists? >log-file [
                            if confirm "install-extensions" [
                                extensions-list>: copy [] 
                                lines: read/lines (>log-file) forall lines [
                                    line: lines/1 parse line [thru [some " "] thru [some " "] copy extension to end] append extensions-list> extension
                                ] 
                                .install-extension (extensions-list>) return true
                            ]
                        ] [
                            print ["log file" clean-path >log-file "doesn't exist"]
                        ]
                    ]
 
                ] [
                    powershell-command: rejoin ["code --install-extension " >extension] 
                    ~out: .call-powershell/out powershell-command
                    unless find ~out "is already installed" [
                        ..log 
                    ]
                    unless silent [
                        ..info-path
                    ]
                ]
            ] {------------- case arg is a single extension ------------/}
            return true
        ]
    ] 
    
    install-extension: :.install-extension 
    .vscode.install: :.install-extension 
    vscode.install: :.install-extension
    .install-extensions: :.install-extension
    install-extensions: :.install-extension







