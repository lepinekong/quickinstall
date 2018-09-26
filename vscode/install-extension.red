Red [
    Title: "install-extension.red"
    .links: [
        https://stackoverflow.com/questions/34286515/how-to-install-visual-studio-code-extensions-from-command-line
    ]
]

if not value? '.redlang [
    do https://redlang.red
]

.redlang [call-powershell log]

.install-extension: function [>extension /silent][

    either block? >extension [
        >extensions: >extension
        forall >extensions [
            extension: >extensions/1
            .install-extension/silent (extension)
        ]
        unless silent [
            print [{log file:} clean-path %install-extension.log ]
        ]        

    ][
        powershell-command: rejoin [{code --install-extension } >extension]
        .call-powershell/out powershell-command
        .log %install-extension.log (>extension)
        unless silent [
            print [{log file:} clean-path %install-extension.log ]
        ]
    ]


]

install: :.install-extension
