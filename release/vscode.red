Red [
    Title: ""
    Description: {Install VSCode}
    Features: [
    
    ]
    Builds:[
        0.0.0.1.1 {Initial build}
    ]
]

if not value? '.quickinstall [
    do https://quickinstall.red
]

.install-vscode: function [/subfolder '>subfolder][
    .install/subfolder https://aka.ms/win32-x64-user-stable D:\Download devtools
]

.alias .install-vscode [
    install-vscode
    vscode
]
