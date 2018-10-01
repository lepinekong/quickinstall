Red [
    Title: ""
]

do https://redlang.red
.redlang [call-powershell get-console-type]

.list-extensions: function [
    /from-log
    /clipboard
    /_build
    /silent    
][

    ..list-extensions: function [
        /clipboard
    ][
        out: call-powershell/out {code --list-extensions}
        if clipboard [
            write-clipboard out
        ]
        return out
    ]

    either from-log [

        __LOG_FILE__: %vscode-extensions.log

        log-file: __LOG_FILE__
        either exists? log-file [
            print read log-file
        ][
            print [{no } __LOG_FILE__]
            print {list vscode extensions installed:}

            either clipboard [
                out: ..list-extensions/clipboard
            ][
                out: ..list-extensions
            ]
            
            return out
        ]
    ][
        ;call-powershell/out {code --list-extensions}
        out: ..list-extensions
        return out
    ]
    
]

.list-extensions
