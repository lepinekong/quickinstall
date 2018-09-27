Red [
    Title: "install-extension.red"
    .links: [
        https://stackoverflow.com/questions/34286515/how-to-install-visual-studio-code-extensions-from-command-line
    ]
]

__VSCODE_EXTENSION_LOG_FILE__: %vscode-extensions.log

if not value? '.redlang [
    do https://redlang.red
]

.redlang [call-powershell log]

.install-extension: function [
    >extension /silent
    /_build
][
    builds>: 0.0.0.1.1

    if _build [
        unless silent [
            ?? builds>
        ]
        return builds
    ]

    info-path: does [
        print [{log file:} clean-path __VSCODE_EXTENSION_LOG_FILE__ ]
    ]

    either block? >extension [
        >extensions: >extension
        forall >extensions [
            extension: >extensions/1
            .install-extension/silent (extension)
        ]
        unless silent [
            info-path
        ]        

    ][
        powershell-command: rejoin [{code --install-extension } >extension]
        .call-powershell/out powershell-command
        .log (__VSCODE_EXTENSION_LOG_FILE__) (>extension)
        unless silent [
            info-path
        ]
    ]
]

install-extension: :.install-extension
.vscode.install: :.install-extension
vscode.install: :.install-extension