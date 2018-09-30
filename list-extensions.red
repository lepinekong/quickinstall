Red [
    Title: ""
]

do https://redlang.red
.redlang [call-powershell]

.list-extensions: function [/from-log][

    ..list-extensions: does [
        call-powershell/out {code --list-extensions}
    ]

    either from-log [

        __LOG_FILE__: %vscode-extensions.log

        either exists? __LOG_FILE__ [
            log-file: __LOG_FILE__
            print read log-file
        ][
            print [{no } __LOG_FILE__]
            print {list vscode extensions installed:}
            ..list-extensions
        ]
    ][
        ;call-powershell/out {code --list-extensions}
        ..list-extensions
    ]
    
]

.list-extensions
