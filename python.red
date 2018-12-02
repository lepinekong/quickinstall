Red [
    Title: "python"
    File: "python"
    UUID: #3b286604-108d-4d23-8eff-a7ed64cb9a2b
    Builds: [
		[0.0.0.1.1.1 {initial build}]
    ]
    Template: [
        Url: https://codeops.red/res/templates/install.red
        UUID: #37daa999-3aad-4bdc-958c-dce3e32e4351
        Date: 2018-11-30
    ]    
]

unless value? '.install [
    do https://quickinstall.red
]

.install-python: function[
    /_debug
][
    >platforms-urls: [
        Windows: https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
    ]
    environment>OS: system/platform

    >url: Select >platforms-urls environment>OS

    if none? >url [
        print [{no download url found for} {nodejs} {in} environment>OS {environment.}]
        >url: ask "Give download url:"
        if >url = "" [
            print ["abort downloading" "python miniconda" "."]
            return false
        ]
        
    ]    
    either _debug [
        do-trace 20 [
            ?? >url
        ] %python
        
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value   
]

install-python: :.install-python
