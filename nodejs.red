Red [
    Title: "install nodejs"
    UUID: #bcad7e65-80ab-498f-b0c8-2b0dfc79d2a2
    Builds: [
		[0.0.0.1.1 {initial build}]
    ]
]

unless value? '.install [
    do https://quickinstall.red
]

.install-nodejs: does [
    return .install https://nodejs.org/dist/v10.14.0/node-v10.14.0-x64.msi
]

install-nodejs: :.install-nodejs
install-node: :.install-nodejs