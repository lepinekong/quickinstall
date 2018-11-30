Red [
    Title: "install nodejs"
    UUID: #0a3b6496-77be-45f6-bf86-65201132a39c
    Builds: [
		[0.0.0.1.2 {release}]
		[0.0.0.1.1 {initial build}]
    ]
]

unless value? '.install [
    do https://quickinstall.red
]

.install-nodejs: function[
    /_debug
][
    either _debug [
        ret>value: .install/_debug https://nodejs.org/dist/v10.14.0/node-v10.14.0-x64.msi
    ][
        ret>value: .install https://nodejs.org/dist/v10.14.0/node-v10.14.0-x64.msi
    ]
    return ret>value
]

install-nodejs: :.install-nodejs
install-node: :.install-nodejs
