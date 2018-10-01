Red [
    
    Title: "install-extension.red"
    UUID: #3b8cd13b-8ed8-4da1-9e3f-e18e82a98f5f
    Builds: [
        0.0.0.1.5 { /from-log
                    /log-file >log-file
        }
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
][
    builds>: 0.0.0.1.1

    if _build [
        unless silent [
            ?? builds>
        ]
        return builds
    ]

    __VSCODE_EXTENSION_LOG_FILE__: %vscode-extensions.log

    ..info-path: does [
        print [{log file:} clean-path __VSCODE_EXTENSION_LOG_FILE__ ]
    ]

    ..log: does [
        .log/separator (__VSCODE_EXTENSION_LOG_FILE__) (>extension) (>separator)
    ]

    unless separator [
        >separator: "(+)"
    ]

    either block? >extension [
        >extensions: >extension
        forall >extensions [
            extension: >extensions/1
            .install-extension/silent (extension)
        ]
        unless silent [
            ..info-path
        ]        

    ][
        >extension: form >extension ; 0.0.0.1.2

        either >extension = "from-log" [
            unless /log-file [
                >log-file: __VSCODE_EXTENSION_LOG_FILE__
            ]
            
            >log-file: to-red-file form >log-file

            either exists? >log-file [
                if confirm {install-extensions} [
                    extensions-list>: copy []
                    lines: read/lines (>log-file)
                    forall lines [
                        line: lines/1
                        parse line [thru [some " "] thru [some " "] copy extension to end]
                        append extensions-list> extension
                    ]
                    .install-extension (extensions-list>)
                    return true
                ]
            ][
                print [{log file} clean-path >log-file {doesn't exist} ]
            ]
        ][
            powershell-command: rejoin [{code --install-extension } >extension]
            .call-powershell/out powershell-command
            ;.log/separator (__VSCODE_EXTENSION_LOG_FILE__) (>extension) (>separator)
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