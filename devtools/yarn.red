Red [
    File: "yarn"
]

unless value? '.install [
    do https://quickinstall.red/install
]

.install-yarn: does [
    return .install https://yarnpkg.com/latest.msi
]

.alias .install-yarn [install-yarn]
