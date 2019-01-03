Red [
    Title: "install-extension.red" 
    UUID: #a7139b7a-c302-4110-8028-ca82fae22371
    Builds: [
		[0.0.0.2.2.1 {reformatting}]
		[0.0.0.2.2 {reformatting}]
        0.0.0.1.5 
        { /from-log^/                    /log-file >log-file^/        }
    ]
]

    if not value? '.redlang [
        do https://redlang.red
    ] 
    .redlang [call-powershell log] 
    
    .install-extension: function [
        '>extension 
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
        ] unless separator [
            >separator: "(+)"
        ] 
        either block? >extension [
            >extensions: >extension 
            forall >extensions [
                extension: >extensions/1 .install-extension/silent (extension)
            ] unless silent [
                ..info-path
            ]
        ] [
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

