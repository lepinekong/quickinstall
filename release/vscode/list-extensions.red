Red [
    Title: ""
    .links: [
        https://stackoverflow.com/questions/35773299/how-can-you-export-vs-code-extension-list
    ]
]

do https://redlang.red
.redlang [call-powershell]

.list-extensions: function [][
    call-powershell/out {code --list-extensions}
]

.list-extensions
