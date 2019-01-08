Red [
    Title: "chocolatey"
    File: "chocolatey"
    UUID: #6123d56f-6836-4e29-b4fb-f917b822688e
    Builds: [
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

unless value? '.install [
    do https://quickinstall.red
]

.install-chocolatey: function[
    /_debug
][
    call/show {powershell -noprofile -ExecutionPolicy Bypass -command "&{ start-process powershell -ArgumentList '-noprofile -command \"iex ((New-Object System.Net.WebClient).DownloadString(''https://chocolatey.org/install.ps1''))\"' -verb RunAs}"}
]

install-chocolatey: :.install-chocolatey
