Red [
    File: "yarn"
]

unless value? '.install [
    do https://quickinstall.red
]

.install-yarn: does [
    return .install https://yarnpkg.com/latest.msi
]

install-yarn: :.install-yarn

