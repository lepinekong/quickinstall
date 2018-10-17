Red [
    Title: ""
    Description: {

    }
]

; unless value? '.redlang [
;     do https://redlang.red
; ]
; .redlang [download alias]
; .quickrun [run]

; .quickinstall: function [
;     param>source-url
;     /download-folder
;     param>download-folder
;     /install-folder
;     param>install-folder
;     /_build
;     /silent
;     /_debug
; ][
;     unless download-folder [
;         param>download-folder: "d:\download\devtools"
;     ]

;     unless install-folder [
;         param>install-folder: "c:\devtools"
;     ]
    
;     if url? param>source-url [
;         out>filename: download (param>source-url) (param>download-folder)
;     ]
;     out>filename: %yarn-1.10.1.msi
;     out-file: rejoin [param>download-folder "\" out>filename]
;     .run (out-file)
; ]

; .alias .quickinstall [quickinstall .install install]
