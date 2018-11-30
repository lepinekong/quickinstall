Red [
    Title: "install nodejs"
    UUID: #c958f388-7d92-46f0-a3fa-2a03e0af6bfb
    Builds: [
		[0.0.0.1.2 {do-trace 20 [}]
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
        do-trace 20 [
            ?? >url
        ] %nodejs.2.red
        
        ret>value: .install/_debug (>url)
    ][
        ret>value: .install (>url)
    ]
    return ret>value
]

install-nodejs: :.install-nodejs
install-node: :.install-nodejs
