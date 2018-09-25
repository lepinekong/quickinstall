Red [
    Title: "install-extension.red"
    .links: [
        https://stackoverflow.com/questions/34286515/how-to-install-visual-studio-code-extensions-from-command-line
    ]
]

if not value? '.redlang [
    do https://redlang.red
]

.redlang [call-powershell]

.install-extension: function [>extension][

    powershell-command: rejoin [{code --install-extension } >extension]
    .call-powershell/out powershell-command

]

install: :.install-extension
