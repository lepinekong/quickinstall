Red [
    Title: "install nodejs"
    UUID: #869c9400-a89e-4c8f-b71a-cb6ed0011126
    Builds: [
		[0.0.0.1.2 {>url: https://nodejs.org/dist/v10.14.0/node-v10.14.0-x64.msi}]
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
    >url: https://nodejs.org/dist/v10.14.0/node-v10.14.0-x64.msi
    either _debug [
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value
]

install-nodejs: :.install-nodejs
install-node: :.install-nodejs
