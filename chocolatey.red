Red [
    Title: "chocolatey"
    File: "chocolatey"
    Build-Purpose: {Test if choco is already installed: 
    see https://stackoverflow.com/questions/48144104/powershell-script-to-install-chocolatey-and-a-list-of-packages
    Test-Path -Path "$env:ProgramData\Chocolatey"
    }
    UUID: #1b3c217b-a68f-45cf-a0ad-8f09d6741d7a
    Builds: [
		[0.0.0.1.1.4 {release}]
		[0.0.0.1.1.3 {Set-ExecutionPolicy Bypass -Scope Process -Force;}]
		[0.0.0.1.1.2 {bypass policy}]
		[0.0.0.1.1.2 {added bypass policy see https://stackoverflow.com/questions/47861537/choco-command-not-recognized-when-run-as-administrator-on-windows?rq=1}]
		[0.0.0.1.1.1 {initial build}]
		[0.0.0.1.1.4 {added builds []}]
    ]
    Links: [
        https://www.topbug.net/blog/2012/07/02/a-simple-tutorial-create-and-publish-chocolatey-packages/
    ]
    Template: [
        Url: https://codeops.red/res/templates/install.red
        UUID: #fc3d5a36-47ed-4000-9c98-8503fbfc144c
        Date: 2018-12-02
        Location: 'Cambodia
        Builds: [
		[0.0.0.1.1.3 {abort downloading" "https://chocolatey.org/install#installing-chocolatey"}]
            [0.0.0.1.1.2 {>url: Select >platforms-urls environment>OS}]
            [0.0.0.1.1.1 {initial build}]
        ]
    ]    
]

unless value? '.redlang [
#include https://redlang.red/redlang    
]

.redlang [call-powershell confirm]


.install-chocolatey: function[
    /_debug
][
    choco-installed?: .call-powershell/out {Test-Path -Path "$env:ProgramData\Chocolatey"}
    choco-installed?: to-logic (replace choco-installed? "^/" "")

    ..do-install: function [][
        call/show {powershell -noprofile -ExecutionPolicy Bypass -command "&{ start-process powershell -ArgumentList '-noprofile -command \"Set-ExecutionPolicy Bypass -Scope Process -Force;iex ((New-Object System.Net.WebClient).DownloadString(''https://chocolatey.org/install.ps1''))\"' -verb RunAs}"}
        return true        
    ]

    ..do-abort: function[][
        print "abort install."
        return false
    ]

    either choco-installed? [
        print "chocolatey is already installed."
        if not .confirm "re-installation" [
            return ..do-abort
            
        ]
    ][
        if not .confirm "installation of chocolatey" [
            return ..do-abort
        ]
    ]

    return ..do-install

]

install-chocolatey: :.install-chocolatey
install-choco: :.install-chocolatey
