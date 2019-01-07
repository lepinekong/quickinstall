Red [
    Title: "install-extension.red" 
    UUID: #5db114c2-53b1-4acc-9425-c6893d33720d
    Builds: [
		[0.0.0.2.2.2 {case arg is an url}]
		[0.0.0.3.1 {removed .section}]
    ]
]

    unless value? '.redlang [
#include https://redlang.red/redlang
    ] 
    .redlang [call-powershell log] 
    
    .install-extension: function [
        '>extension "name or extension url"
        /log-file >log-file 
        /separator >separator 
        /silent 
        /_build
    ] [
        builds>: 0.0.0.1.1 
        if _build [
            unless silent [
                ?? builds>
            ] 
            return builds
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
            >extensions: >extension 
            forall >extensions [
                extension: >extensions/1 .install-extension/silent (extension)
            ] unless silent [
                ..info-path
            ]
        ] [
            ; .section {
            ;     case arg is an url
            ;     example: https://marketplace.visualstudio.com/items?itemName=red-auto.red
            ; } [

            ]
            if url? :>extension [
                parse url [thru "itemName=" copy >extension to end]
            ]

            >extension: form >extension 
            either >extension = "from-log" [
                unless /log-file [
                    >log-file: __VSCODE_EXTENSION_LOG_FILE__
                ] 
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
            ] [
                powershell-command: rejoin ["code --install-extension " >extension] .call-powershell/out powershell-command 
                ..log 
                unless silent [
                    ..info-path
                ]
            ]
        ]
    ] 
    install-extension: :.install-extension 
    .vscode.install: :.install-extension 
    vscode.install: :.install-extension
    .install-extensions: :.install-extension
    install-extensions: :.install-extension

