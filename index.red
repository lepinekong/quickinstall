Red [
    Title: ""
    Description: {

    }
]

unless value? '.quickinstall [
    do https://redlang.red/quickinstall
]

.quickinstall/load-only [install] ; load install.red
