Red []

unless value? '.redlang [
    do https://redlang.red
]
.redlang [alias]
.quickinstall/load-only [install]

.install-vscode: does [
    return .install https://aka.ms/win32-x64-user-stable
]

.alias .install-vscode [install-vscode]
